data "azurerm_resource_group" "app_rg" {
  name = var.resource_group_name
}

data "azurerm_container_registry" "container_registry" {
  name = var.container_registry_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "log-${var.app}"
  location            = data.azurerm_resource_group.app_rg.location
  resource_group_name = data.azurerm_resource_group.app_rg.name
  
}

resource "azurerm_container_app_environment" "container_app_environment" {
  name                      = "cae-${var.app}-${var.env}"
  location                   = data.azurerm_resource_group.app_rg.location
  resource_group_name        = data.azurerm_resource_group.app_rg.name
  log_analytics_workspace_id = azurerm_log_analytics_workspace.log_analytics.id

}

resource "azurerm_container_app" "container_app" {
  name                         = "${var.app}"
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = data.azurerm_resource_group.app_rg.name
  revision_mode                = "Single"
  template {
    container {
      name   = "${var.app}"
      image  = "terraformcontainer.azurecr.io/images/python-flash-app:latest"
      cpu    = "0.5"
      memory = "1Gi"
      
    }
  }
  secret {
    name  = "registry-credentials"
    value = data.azurerm_container_registry.container_registry.admin_password
  }

  registry {
    server               = data.azurerm_container_registry.container_registry.login_server
    username             = data.azurerm_container_registry.container_registry.admin_username
    password_secret_name = "registry-credentials"
  }
}
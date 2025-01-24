variable "region" {
  description = "Azure infrastructure region"
  type    = string
  default = "East US"
}

variable "app" {
  description = "Application that we want to deploy"
  type    = string
  default = "python-flash-app"
}

variable "env" {
  description = "Application env"
  type    = string
  default = "dev"
}

variable "location" {
  description = "Location short name "
  type    = string
  default = "eus"
}

variable "resource_group_name" {
    default = "terraform-rg"
}

variable "container_registry_name" {
    default = "terraformcontainer"
}

variable "container_user" {
    type = string
    default = "terraformcontainer"
}
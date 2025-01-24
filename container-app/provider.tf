terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.1.0"
    }
  }
}

provider "azurerm" {
    subscription_id = "b65b063e-97eb-49f7-8d67-cb4d7fc0d5d5"
    features {}
}
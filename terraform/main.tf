terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.85.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.11.0"
    }
  }

  required_version = ">= 1.6.6"
}

provider "azurerm" {
  features {}
}

provider "azapi" {
}

data "azurerm_client_config" "current" {}

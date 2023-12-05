terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }

  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}-${var.env_name}"
  location = var.resource_group_location

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_kubernetes_cluster" "cluster" {
  name                = "${var.cluster_name}-${var.env_name}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = "${var.cluster_name}-${var.env_name}"

  tags = {
    environment = var.env_name
  }

  default_node_pool {
    name       = "default"
    node_count = var.node_count
    vm_size    = var.instance_type
  }

  service_principal {
    client_id     = var.aks_service_principal_client_id
    client_secret = var.aks_service_principal_client_secret
  }

  role_based_access_control_enabled = true
}

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

  identity {
    type = "SystemAssigned"
  }

}

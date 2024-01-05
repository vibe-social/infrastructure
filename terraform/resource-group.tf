resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group_name}-${var.env_name}"
  location = var.resource_group_location

  tags = {
    environment = var.env_name
  }
}

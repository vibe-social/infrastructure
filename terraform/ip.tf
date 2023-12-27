resource "azurerm_public_ip" "public_ip" {
  name                = "${var.project_name}-ip"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  allocation_method   = "Static"
  sku                 = "Standard"
  domain_name_label   = var.project_name
}

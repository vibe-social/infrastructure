resource "azurerm_dns_zone" "dns_zone" {
  name                = "${var.project_name}.com"
  resource_group_name = azurerm_resource_group.resource_group.name
}


resource "azurerm_dns_a_record" "dns_record" {
  name                = var.project_name
  zone_name           = azurerm_dns_zone.dns_zone.name
  resource_group_name = azurerm_resource_group.resource_group.name
  ttl                 = 300
  records             = [azurerm_public_ip.public_ip.ip_address]
}

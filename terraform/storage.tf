resource "azurerm_storage_account" "storage_account" {
  name                     = "vibesocialstorageaccount"
  resource_group_name      = azurerm_resource_group.resource_group.name
  location                 = azurerm_resource_group.resource_group.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_storage_container" "storage_container" {
  name                  = "${var.project_name}-eventhub-archive"
  storage_account_name  = azurerm_storage_account.storage_account.name
  container_access_type = "private"
}

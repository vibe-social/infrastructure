resource "azurerm_eventhub_namespace" "eventhub_namespace" {
  name                = "${var.project_name}-eventhub"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  sku                 = "Standard"
  capacity            = 1

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_eventhub" "eventhub" {
  name                = "${var.project_name}-eventhub"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = azurerm_resource_group.resource_group.name
  partition_count     = 2
  message_retention   = 1

  capture_description {
    enabled             = true
    encoding            = "Avro"
    interval_in_seconds = 120
    size_limit_in_bytes = 10485760

    destination {
      name                = "EventHubArchive.AzureBlockBlob"
      archive_name_format = "{Namespace}/{EventHub}/{PartitionId}/{Year}/{Month}/{Day}/{Hour}/{Minute}/{Second}"
      blob_container_name = "eventhub-archive"
      storage_account_id  = azurerm_storage_account.storage_account.id
    }
  }
}

resource "azurerm_eventhub_authorization_rule" "eventhub_authorization_rule" {
  name                = "${var.project_name}-eventhub-authorization-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = azurerm_resource_group.resource_group.name
  eventhub_name       = azurerm_eventhub.eventhub.name
  listen              = true
  send                = true
  manage              = false
}

resource "azurerm_eventhub_namespace_authorization_rule" "eventhub_namespace_authorization_rule" {
  name                = "${var.project_name}-eventhub-namespace-authorization-rule"
  namespace_name      = azurerm_eventhub_namespace.eventhub_namespace.name
  resource_group_name = azurerm_resource_group.resource_group.name
  listen              = true
  send                = true
  manage              = false
}

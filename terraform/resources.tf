resource "azapi_update_resource" "update_resource" {
  type        = "Microsoft.ContainerService/managedClusters@2023-07-01"
  resource_id = azurerm_kubernetes_cluster.cluster.id

  body = jsonencode({
    properties = {
      networkProfile = {
        monitoring = {
          enabled = true
        }
      }
    }
  })

  depends_on = [
    azurerm_monitor_data_collection_rule_association.monitor_rule_association,
    azurerm_monitor_data_collection_rule_association.monitor_endpoint_association
  ]
}

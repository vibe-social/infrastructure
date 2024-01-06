resource "azurerm_monitor_workspace" "monitor_workspace" {
  name                          = "${var.project_name}-monitor-workspace"
  location                      = azurerm_resource_group.resource_group.location
  resource_group_name           = azurerm_resource_group.resource_group.name
  public_network_access_enabled = true

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_monitor_data_collection_endpoint" "monitor_endpoint" {
  name                = "${var.project_name}-monitor-endpoint"
  resource_group_name = azurerm_resource_group.resource_group.name
  location            = azurerm_resource_group.resource_group.location
  kind                = "Linux"
}

resource "azurerm_monitor_data_collection_rule" "monitor_rule" {
  name                        = "${var.project_name}-monitor-rule"
  resource_group_name         = azurerm_resource_group.resource_group.name
  location                    = azurerm_resource_group.resource_group.location
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.monitor_endpoint.id

  data_sources {
    prometheus_forwarder {
      name    = "PrometheusDataSource"
      streams = ["Microsoft-PrometheusMetrics"]
    }
  }

  destinations {
    monitor_account {
      monitor_account_id = azurerm_monitor_workspace.monitor_workspace.id
      name               = azurerm_monitor_workspace.monitor_workspace.name
    }
  }

  data_flow {
    streams      = ["Microsoft-PrometheusMetrics"]
    destinations = [azurerm_monitor_workspace.monitor_workspace.name]
  }
}

resource "azurerm_monitor_data_collection_rule_association" "monitor_rule_association" {
  name                    = "${var.project_name}-monitor-rule-association"
  target_resource_id      = azurerm_kubernetes_cluster.cluster.id
  data_collection_rule_id = azurerm_monitor_data_collection_rule.monitor_rule.id
}

resource "azurerm_monitor_data_collection_rule_association" "monitor_endpoint_association" {
  target_resource_id          = azurerm_kubernetes_cluster.cluster.id
  data_collection_endpoint_id = azurerm_monitor_data_collection_endpoint.monitor_endpoint.id
}

resource "azurerm_dashboard_grafana" "grafana_dashbaord" {
  name                          = "${var.project_name}-grafana"
  resource_group_name           = azurerm_resource_group.resource_group.name
  location                      = azurerm_resource_group.resource_group.location
  public_network_access_enabled = true

  identity {
    type = "SystemAssigned"
  }

  azure_monitor_workspace_integrations {
    resource_id = azurerm_monitor_workspace.monitor_workspace.id
  }

  tags = {
    environment = var.env_name
  }
}

resource "azurerm_role_assignment" "prometheus_role_data_reader" {
  scope                = azurerm_monitor_workspace.monitor_workspace.id
  role_definition_name = "Monitoring Data Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "grafana_role_data_reader" {
  scope                = azurerm_monitor_workspace.monitor_workspace.id
  role_definition_name = "Monitoring Data Reader"
  principal_id         = azurerm_dashboard_grafana.grafana_dashbaord.identity[0].principal_id
}

resource "azurerm_role_assignment" "grafana_role_admin" {
  scope                = azurerm_dashboard_grafana.grafana_dashbaord.id
  role_definition_name = "Grafana Admin"
  principal_id         = data.azurerm_client_config.current.object_id
}

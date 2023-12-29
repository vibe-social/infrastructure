resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.cluster]
  filename   = "kubeconfig-${var.env_name}"
  content    = azurerm_kubernetes_cluster.cluster.kube_config_raw
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config.0.client_certificate
  sensitive = true
}

output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.cluster.kube_config_raw
  sensitive = true
}

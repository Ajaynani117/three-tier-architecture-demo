resource "azurerm_monitor_action_group" "this" {
  name                = var.action_group_name
  resource_group_name = var.resource_group_name
  short_name          = var.action_group_short_name

  email_receiver {
    name                    = var.email_receiver_name
    email_address           = var.email_receiver_address
    use_common_alert_schema = true
  }

  tags = var.tags
}
resource "azurerm_monitor_metric_alert" "aks_cpu_high" {
  name                = "alert-aks-cpu-high"
  resource_group_name = var.resource_group_name

  scopes = [
    var.aks_cluster_id
  ]

  description = "Alert when AKS CPU usage is high"

  severity = 2
  enabled  = true

  frequency   = "PT5M"
  window_size = "PT15M"

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.cpu_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.this.id
  }

  tags = var.tags
}
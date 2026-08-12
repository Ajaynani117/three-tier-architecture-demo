output "action_group_id" {
  description = "Azure Monitor Action Group resource ID"
  value       = azurerm_monitor_action_group.this.id
}

output "action_group_name" {
  description = "Azure Monitor Action Group name"
  value       = azurerm_monitor_action_group.this.name
}

output "aks_cpu_alert_id" {
  description = "AKS CPU metric alert resource ID"
  value       = azurerm_monitor_metric_alert.aks_cpu_high.id
}
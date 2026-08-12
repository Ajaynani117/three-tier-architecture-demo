output "id" {
  description = "Azure resource ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.id
}

output "name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.name
}

output "workspace_id" {
  description = "Customer/workspace ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.this.workspace_id
}
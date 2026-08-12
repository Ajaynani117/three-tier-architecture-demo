output "id" {
  description = "Resource ID of the managed identity"
  value       = azurerm_user_assigned_identity.this.id
}

output "name" {
  description = "Name of the managed identity"
  value       = azurerm_user_assigned_identity.this.name
}

output "client_id" {
  description = "Client ID of the managed identity"
  value       = azurerm_user_assigned_identity.this.client_id
}

output "principal_id" {
  description = "Microsoft Entra principal ID of the managed identity"
  value       = azurerm_user_assigned_identity.this.principal_id
}
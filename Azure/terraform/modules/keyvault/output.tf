output "id" {
  description = "Azure Key Vault resource ID"
  value       = azurerm_key_vault.this.id
}

output "name" {
  description = "Azure Key Vault name"
  value       = azurerm_key_vault.this.name
}

output "vault_uri" {
  description = "URI used to access Azure Key Vault"
  value       = azurerm_key_vault.this.vault_uri
}
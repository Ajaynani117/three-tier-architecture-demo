output "id" {
  description = "Resource ID of Azure Container Registry"
  value       = azurerm_container_registry.this.id
}

output "name" {
  description = "Name of Azure Container Registry"
  value       = azurerm_container_registry.this.name
}

output "login_server" {
  description = "Login server URL of Azure Container Registry"
  value       = azurerm_container_registry.this.login_server
}
output "id" {
  description = "Resource ID of Application Gateway"
  value       = azurerm_application_gateway.this.id
}

output "name" {
  description = "Name of Application Gateway"
  value       = azurerm_application_gateway.this.name
}

output "public_ip_id" {
  description = "Resource ID of the Application Gateway public IP"
  value       = azurerm_public_ip.this.id
}

output "public_ip_address" {
  description = "Public IP address of Application Gateway"
  value       = azurerm_public_ip.this.ip_address
}
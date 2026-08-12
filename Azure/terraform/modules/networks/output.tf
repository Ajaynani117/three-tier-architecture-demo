output "id" {
  description = "Virtual network ID"
  value       = azurerm_virtual_network.this.id
}

output "name" {
  description = "Virtual network name"
  value       = azurerm_virtual_network.this.name
}

output "subnet_ids" {
  description = "Map of subnet IDs"

  value = {
    for key, subnet in azurerm_subnet.this :
    key => subnet.id
  }
}
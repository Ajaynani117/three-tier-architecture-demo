output "network_security_group_ids" {
  description = "Map of created NSG IDs"

  value = {
    for key, nsg in azurerm_network_security_group.this :
    key => nsg.id
  }
}

output "network_security_group_names" {
  description = "Map of created NSG names"

  value = {
    for key, nsg in azurerm_network_security_group.this :
    key => nsg.name
  }
}
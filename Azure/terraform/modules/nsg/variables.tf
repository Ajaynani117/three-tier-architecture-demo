variable "location" {
  description = "Azure region where the NSGs are created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the NSGs"
  type        = string
}

variable "network_security_groups" {
  description = "Map of NSGs, subnet associations, and security rules"

  type = map(object({
    name      = string
    subnet_id = string

    security_rules = list(object({
      name                       = string
      priority                   = number
      direction                  = string
      access                     = string
      protocol                   = string
      source_port_range          = string
      destination_port_range     = string
      source_address_prefix      = string
      destination_address_prefix = string
    }))
  }))
}

variable "tags" {
  description = "Tags applied to the NSGs"
  type        = map(string)
  default     = {}
}
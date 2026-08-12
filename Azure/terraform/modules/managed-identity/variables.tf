variable "name" {
  description = "Name of the user-assigned managed identity"
  type        = string
}

variable "location" {
  description = "Azure region where the managed identity is created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the managed identity"
  type        = string
}

variable "tags" {
  description = "Tags applied to the managed identity"
  type        = map(string)
  default     = {}
}
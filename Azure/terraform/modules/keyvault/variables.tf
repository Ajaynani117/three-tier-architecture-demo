variable "name" {
  description = "Name of the Azure Key Vault"
  type        = string
}

variable "location" {
  description = "Azure region where Key Vault is created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID"
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU"
  type        = string
  default     = "standard"

  validation {
    condition     = contains(["standard", "premium"], var.sku_name)
    error_message = "Key Vault SKU must be standard or premium."
  }
}

variable "soft_delete_retention_days" {
  description = "Number of days deleted Key Vault objects are retained"
  type        = number
  default     = 7
}

variable "purge_protection_enabled" {
  description = "Prevents permanent deletion during retention period"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Allow public network access to Key Vault"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags applied to Key Vault"
  type        = map(string)
  default     = {}
}
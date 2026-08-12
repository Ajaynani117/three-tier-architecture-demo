variable "name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "location" {
  description = "Azure region where ACR is created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing ACR"
  type        = string
}

variable "sku" {
  description = "Azure Container Registry SKU"
  type        = string
  default     = "Standard"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "ACR SKU must be Basic, Standard, or Premium."
  }
}

variable "admin_enabled" {
  description = "Enable the ACR admin account"
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags applied to ACR"
  type        = map(string)
  default     = {}
}
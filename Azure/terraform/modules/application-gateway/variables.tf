variable "name" {
  description = "Name of the Azure Application Gateway"
  type        = string
}

variable "public_ip_name" {
  description = "Name of the Application Gateway public IP"
  type        = string
}

variable "location" {
  description = "Azure region where Application Gateway is created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing Application Gateway"
  type        = string
}

variable "subnet_id" {
  description = "Dedicated Application Gateway subnet ID"
  type        = string
}

variable "capacity" {
  description = "Number of Application Gateway instances"
  type        = number
  default     = 1

  validation {
    condition     = var.capacity >= 1
    error_message = "Application Gateway capacity must be at least 1."
  }
}

variable "tags" {
  description = "Tags applied to Application Gateway resources"
  type        = map(string)
  default     = {}
}


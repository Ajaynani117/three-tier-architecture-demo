variable "name" {
  description = "Name of the Log Analytics workspace"
  type        = string
}

variable "location" {
  description = "Azure region where the Log Analytics workspace is created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Log Analytics workspace"
  type        = string
}

variable "sku" {
  description = "Pricing SKU of the Log Analytics workspace"
  type        = string
  default     = "PerGB2018"
}

variable "retention_in_days" {
  description = "Number of days Log Analytics data is retained"
  type        = number
  default     = 30

  validation {
    condition = contains(
      [30, 31, 60, 90, 120, 180, 270, 365, 550, 730],
      var.retention_in_days
    )

    error_message = "Retention must be one of: 30, 31, 60, 90, 120, 180, 270, 365, 550, or 730 days."
  }
}

variable "tags" {
  description = "Tags applied to the Log Analytics workspace"
  type        = map(string)
  default     = {}
}
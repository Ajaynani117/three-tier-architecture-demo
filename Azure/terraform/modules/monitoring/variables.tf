variable "resource_group_name" {
  description = "Resource group where monitoring resources are created"
  type        = string
}

variable "aks_cluster_id" {
  description = "Resource ID of the AKS cluster to monitor"
  type        = string
}

variable "action_group_name" {
  description = "Name of the Azure Monitor Action Group"
  type        = string
}

variable "action_group_short_name" {
  description = "Short name of the Action Group"
  type        = string
}

variable "email_receiver_name" {
  description = "Name of the email receiver"
  type        = string
}

variable "email_receiver_address" {
  description = "Email address used for Azure Monitor alerts"
  type        = string
}

variable "cpu_threshold" {
  description = "CPU threshold that triggers the AKS alert"
  type        = number
  default     = 80
}

variable "tags" {
  description = "Tags applied to monitoring resources"
  type        = map(string)
  default     = {}
}
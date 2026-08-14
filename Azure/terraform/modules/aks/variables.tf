variable "name" {
  description = "Name of the AKS cluster"
  type        = string
}

variable "dns_prefix" {
  description = "DNS prefix used by the AKS API server"
  type        = string
}

variable "location" {
  description = "Azure region where AKS is created"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the AKS cluster"
  type        = string
}

variable "node_resource_group_name" {
  description = "Resource group used by AKS for managed infrastructure"
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID used by the AKS nodes"
  type        = string
}

variable "managed_identity_id" {
  description = "User-assigned managed identity attached to AKS"
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Azure resource ID of the Log Analytics workspace"
  type        = string
}

variable "application_gateway_id" {
  description = "Resource ID of the existing Application Gateway"
  type        = string
}

variable "node_vm_size" {
  description = "VM size used by the system node pool"
  type        = string
  default     = "Standard_D4as_v7"
}

variable "node_count" {
  description = "Initial system node count"
  type        = number
  default     = 2
}

variable "min_node_count" {
  description = "Minimum system node count"
  type        = number
  default     = 1
}

variable "max_node_count" {
  description = "Maximum system node count"
  type        = number
  default     = 4
}

variable "pod_cidr" {
  description = "CIDR used by pods in Azure CNI Overlay"
  type        = string
  default     = "10.244.0.0/16"
}

variable "service_cidr" {
  description = "CIDR used by Kubernetes services"
  type        = string
  default     = "10.100.0.0/16"
}

variable "dns_service_ip" {
  description = "IP address used by Kubernetes DNS"
  type        = string
  default     = "10.100.0.10"
}

variable "tags" {
  description = "Tags applied to the AKS cluster"
  type        = map(string)
  default     = {}
}

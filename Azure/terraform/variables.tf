variable "subscription_id" {
  description = "Azure subscription ID"
  type        = string
}

variable "location" {
  description = "Azure deployment region"
  type        = string
  default     = "centralus"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "robotshop"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "vnet_address_space" {
  description = "Virtual network address space"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "aks_subnet_prefix" {
  description = "AKS subnet address prefix"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

variable "appgw_subnet_prefix" {
  description = "Application Gateway subnet address prefix"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "tags" {
  description = "Common Azure resource tags"
  type        = map(string)

  default = {
    ManagedBy = "Terraform"
    Project   = "RobotShop"
  }
}

variable "log_analytics_retention_in_days" {
  description = "Number of days Log Analytics data is retained"
  type        = number
  default     = 30

  validation {
    condition = contains(
      [30, 31, 60, 90, 120, 180, 270, 365, 550, 730],
      var.log_analytics_retention_in_days
    )

    error_message = "Log Analytics retention must be a supported Azure retention value."
  }
}
variable "application_gateway_capacity" {
  description = "Application Gateway instance capacity"
  type        = number
  default     = 1

  validation {
    condition     = var.application_gateway_capacity >= 1
    error_message = "Application Gateway capacity must be at least 1."
  }
}
variable "aks_node_vm_size" {
  description = "VM size used by the AKS system node pool"
  type        = string
  default     = "Standard_D4as_v7"
}

variable "aks_node_count" {
  description = "Initial AKS system node count"
  type        = number
  default     = 2
}

variable "aks_min_node_count" {
  description = "Minimum AKS system node count"
  type        = number
  default     = 1
}

variable "aks_max_node_count" {
  description = "Maximum AKS system node count"
  type        = number
  default     = 4
}

variable "aks_pod_cidr" {
  description = "CIDR used by AKS pods"
  type        = string
  default     = "10.244.0.0/16"
}

variable "aks_service_cidr" {
  description = "CIDR used by Kubernetes services"
  type        = string
  default     = "10.100.0.0/16"
}

variable "aks_dns_service_ip" {
  description = "IP address used by Kubernetes DNS"
  type        = string
  default     = "10.100.0.10"
}
variable "acr_sku" {
  description = "SKU used by Azure Container Registry"
  type        = string
  default     = "Standard"
}
variable "monitoring_email" {
  description = "Email address used for Azure Monitor alerts"
  type        = string
}

variable "aks_cpu_alert_threshold" {
  description = "AKS CPU percentage threshold"
  type        = number
  default     = 80
}

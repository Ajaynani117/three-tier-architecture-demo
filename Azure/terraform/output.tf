output "resource_group_name" {
  value = module.resource_group.name
}

output "virtual_network_name" {
  value = module.networks.name
}

output "aks_subnet_id" {
  value = module.networks.subnet_ids["aks"]
}

output "application_gateway_subnet_id" {
  value = module.networks.subnet_ids["application_gateway"]
}

output "aks_network_security_group_id" {
  description = "AKS subnet NSG ID"
  value       = module.nsg.network_security_group_ids["aks"]
}

output "application_gateway_network_security_group_id" {
  description = "Application Gateway subnet NSG ID"
  value       = module.nsg.network_security_group_ids["application_gateway"]
}

output "network_security_group_names" {
  description = "Names of all network security groups"
  value       = module.nsg.network_security_group_names
}
output "managed_identity_id" {
  description = "Resource ID of the AKS managed identity"
  value       = module.managed_identity.id
}

output "managed_identity_client_id" {
  description = "Client ID of the AKS managed identity"
  value       = module.managed_identity.client_id
}

output "managed_identity_principal_id" {
  description = "Principal ID of the AKS managed identity"
  value       = module.managed_identity.principal_id
}

output "log_analytics_workspace_id" {
  description = "Azure resource ID of the Log Analytics workspace"
  value       = module.log_analytics.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = module.log_analytics.name
}

output "log_analytics_customer_id" {
  description = "Customer/workspace ID of the Log Analytics workspace"
  value       = module.log_analytics.workspace_id
}
output "application_gateway_id" {
  description = "Resource ID of Application Gateway"
  value       = module.application_gateway.id
}

output "application_gateway_name" {
  description = "Name of Application Gateway"
  value       = module.application_gateway.name
}

output "application_gateway_public_ip" {
  description = "Public IP address of Application Gateway"
  value       = module.application_gateway.public_ip_address
}
output "aks_cluster_id" {
  description = "Resource ID of the AKS cluster"
  value       = module.aks.id
}

output "aks_cluster_name" {
  description = "Name of the AKS cluster"
  value       = module.aks.name
}

output "aks_fqdn" {
  description = "AKS API server FQDN"
  value       = module.aks.fqdn
}
output "acr_id" {
  description = "Azure Container Registry resource ID"
  value       = module.acr.id
}

output "acr_name" {
  description = "Azure Container Registry name"
  value       = module.acr.name
}

output "acr_login_server" {
  description = "Azure Container Registry login server"
  value       = module.acr.login_server
}
output "aks_oidc_issuer_url" {
  description = "AKS OIDC issuer URL"
  value       = module.aks.oidc_issuer_url
}

output "aks_get_credentials_command" {
  value = join("", [
    "az aks get-credentials ",
    "--resource-group ${module.resource_group.name} ",
    "--name ${module.aks.name} ",
    "--overwrite-existing"
  ])
}
output "keyvault_id" {
  description = "Azure Key Vault resource ID"
  value       = module.keyvault.id
}

output "keyvault_name" {
  description = "Azure Key Vault name"
  value       = module.keyvault.name
}

output "keyvault_uri" {
  description = "Azure Key Vault URI"
  value       = module.keyvault.vault_uri
}
output "monitoring_action_group_id" {
  description = "Azure Monitor Action Group ID"
  value       = module.monitoring.action_group_id
}

output "monitoring_action_group_name" {
  description = "Azure Monitor Action Group name"
  value       = module.monitoring.action_group_name
}

output "aks_cpu_alert_id" {
  description = "AKS CPU alert ID"
  value       = module.monitoring.aks_cpu_alert_id
}
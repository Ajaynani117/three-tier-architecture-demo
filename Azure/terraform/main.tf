locals {
  name_prefix = "${var.project_name}-${var.environment}"

  common_tags = merge(
    var.tags,
    {
      Environment = var.environment
    }
  )
}

module "resource_group" {
  source = "./modules/resource-group"

  name     = "rg-${local.name_prefix}"
  location = var.location
  tags     = local.common_tags
}

module "networks" {
  source = "./modules/networks"

  name                = "vnet-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  address_space       = var.vnet_address_space

  subnets = {
    aks = {
      name             = "snet-aks"
      address_prefixes = var.aks_subnet_prefix
    }

    application_gateway = {
      name             = "snet-appgw"
      address_prefixes = var.appgw_subnet_prefix
    }
  }

  tags = local.common_tags
}

module "nsg" {
  source = "./modules/nsg"

  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  network_security_groups = {
    aks = {
      name      = "nsg-aks-${local.name_prefix}"
      subnet_id = module.networks.subnet_ids["aks"]

      security_rules = [
        {
          name                       = "AllowAzureLoadBalancer"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "AzureLoadBalancer"
          destination_address_prefix = "*"
        }
      ]
    }

    application_gateway = {
      name      = "nsg-appgw-${local.name_prefix}"
      subnet_id = module.networks.subnet_ids["application_gateway"]

      security_rules = [
        {
          name                       = "AllowGatewayManager"
          priority                   = 100
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "65200-65535"
          source_address_prefix      = "GatewayManager"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowAzureLoadBalancer"
          priority                   = 110
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "*"
          source_port_range          = "*"
          destination_port_range     = "*"
          source_address_prefix      = "AzureLoadBalancer"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowHTTP"
          priority                   = 120
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "80"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        },
        {
          name                       = "AllowHTTPS"
          priority                   = 130
          direction                  = "Inbound"
          access                     = "Allow"
          protocol                   = "Tcp"
          source_port_range          = "*"
          destination_port_range     = "443"
          source_address_prefix      = "Internet"
          destination_address_prefix = "*"
        }
      ]
    }
  }

  tags = local.common_tags
}

module "managed_identity" {
  source = "./modules/managed-identity"

  name                = "id-aks-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name
  tags                = local.common_tags
}

module "log_analytics" {
  source = "./modules/log-analytics"

  name                = "log-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku               = "PerGB2018"
  retention_in_days = var.log_analytics_retention_in_days

  tags = local.common_tags
}
module "application_gateway" {
  source = "./modules/application-gateway"

  name                = "agw-${local.name_prefix}"
  public_ip_name      = "pip-agw-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  subnet_id = module.networks.subnet_ids["application_gateway"]
  capacity  = var.application_gateway_capacity

  tags = local.common_tags

  depends_on = [
    module.nsg
  ]
}

resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = module.networks.subnet_ids["aks"]
  role_definition_name = "Network Contributor"
  principal_id         = module.managed_identity.principal_id
}

module "aks" {
  source = "./modules/aks"

  name                     = "aks-${local.name_prefix}"
  dns_prefix               = "aks-${local.name_prefix}"
  node_resource_group_name = "rg-${local.name_prefix}-nodes"

  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  subnet_id                  = module.networks.subnet_ids["aks"]
  managed_identity_id        = module.managed_identity.id
  log_analytics_workspace_id = module.log_analytics.id
  application_gateway_id     = module.application_gateway.id

  node_vm_size   = var.aks_node_vm_size
  node_count     = var.aks_node_count
  min_node_count = var.aks_min_node_count
  max_node_count = var.aks_max_node_count

  pod_cidr       = var.aks_pod_cidr
  service_cidr   = var.aks_service_cidr
  dns_service_ip = var.aks_dns_service_ip

  tags = local.common_tags

  depends_on = [
    module.nsg,
    azurerm_role_assignment.aks_network_contributor
  ]
}
resource "azurerm_role_assignment" "agic_application_gateway_contributor" {
  scope                = module.application_gateway.id
  role_definition_name = "Contributor"
  principal_id         = module.aks.agic_identity_object_id
}

resource "azurerm_role_assignment" "agic_resource_group_reader" {
  scope                = module.resource_group.id
  role_definition_name = "Reader"
  principal_id         = module.aks.agic_identity_object_id
}
module "acr" {
  source = "./modules/acr"

  name                = "acrrobotshop${var.environment}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  sku           = var.acr_sku
  admin_enabled = false

  tags = local.common_tags
}
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                = module.acr.id
  role_definition_name = "AcrPull"
  principal_id         = module.aks.kubelet_identity_object_id
}
module "keyvault" {
  source = "./modules/keyvault"

  name                = "kv-${local.name_prefix}"
  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  tenant_id = data.azurerm_client_config.current.tenant_id

  sku_name = "standard"

  soft_delete_retention_days = 7
  purge_protection_enabled   = false

  public_network_access_enabled = true

  tags = local.common_tags
}
data "azurerm_client_config" "current" {}
module "monitoring" {
  source = "./modules/monitoring"

  resource_group_name = module.resource_group.name

  aks_cluster_id = module.aks.id

  action_group_name       = "ag-monitoring-${local.name_prefix}"
  action_group_short_name = "robotshop"

  email_receiver_name    = "DevOpsTeam"
  email_receiver_address = var.monitoring_email

  cpu_threshold = var.aks_cpu_alert_threshold

  tags = local.common_tags
}
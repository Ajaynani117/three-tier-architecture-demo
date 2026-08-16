resource "azurerm_kubernetes_cluster" "this" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  node_resource_group = var.node_resource_group_name
  dns_prefix          = var.dns_prefix

  sku_tier = "Free"

  node_provisioning_profile {
    mode = "Manual"
  }

  role_based_access_control_enabled = true
  local_account_disabled            = false

  oidc_issuer_enabled       = true
  workload_identity_enabled = true
  azure_policy_enabled      = true

  default_node_pool {
    name           = "system"
    vm_size        = var.node_vm_size
    vnet_subnet_id = var.subnet_id

    auto_scaling_enabled = true
    node_count           = var.node_count
    min_count            = var.min_node_count
    max_count            = var.max_node_count

    os_disk_size_gb = 64
    os_disk_type    = "Managed"
    type            = "VirtualMachineScaleSets"

    only_critical_addons_enabled = true

   
  upgrade_settings {
    max_surge       = "0"
    max_unavailable = "1"
  }

    node_labels = {
      "nodepool-type" = "system"
    }

    tags = var.tags
  }

  identity {
    type = "UserAssigned"

    identity_ids = [
      var.managed_identity_id
    ]
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    network_policy      = "azure"

    load_balancer_sku = "standard"
    outbound_type     = "loadBalancer"

    pod_cidr       = var.pod_cidr
    service_cidr   = var.service_cidr
    dns_service_ip = var.dns_service_ip
  }

  oms_agent {
    log_analytics_workspace_id      = var.log_analytics_workspace_id
    msi_auth_for_monitoring_enabled = true
  }

  ingress_application_gateway {
    gateway_id = var.application_gateway_id
  }

  key_vault_secrets_provider {
    secret_rotation_enabled  = true
    secret_rotation_interval = "2m"
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count
    ]
  }

  tags = var.tags
}

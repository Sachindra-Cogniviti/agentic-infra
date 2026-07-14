# User Assigned Identity for AKS Control Plane
resource "azurerm_user_assigned_identity" "aks" {
  name                = "${var.environment}-aks-identity"
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

# Grant the AKS Identity "Network Contributor" role on the subnet
resource "azurerm_role_assignment" "aks_subnet" {
  scope                = var.subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.aks.principal_id
}

# AKS Cluster definition
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.environment}-aks-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "${var.environment}-aks"

  azure_policy_enabled      = true
  oidc_issuer_enabled       = true
  workload_identity_enabled = true

  default_node_pool {
    name           = "system"
    node_count     = var.node_count
    vm_size        = var.vm_size
    vnet_subnet_id = var.subnet_id
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks.id]
  }

  network_profile {
    network_plugin      = "azure"
    network_plugin_mode = "overlay"
    pod_cidr            = "192.168.0.0/16"
    service_cidr        = "10.240.0.0/16"
    dns_service_ip      = "10.240.0.10"
  }

  tags = var.tags

  depends_on = [
    azurerm_role_assignment.aks_subnet
  ]
}

# Attach ACR (AcrPull role)
resource "azurerm_role_assignment" "acr" {
  scope                = var.acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

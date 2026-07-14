module "network" {
  source = "../../../modules/azure/network"

  environment         = var.environment
  location            = "Central India"
  resource_group_name = "rg-dev-network"
  vnet_cidr           = "10.0.0.0/16"
  aks_subnet_cidr     = "10.0.1.0/24"
}

module "acr" {
  source = "../../../modules/azure/acr"

  acr_name            = "devagentacr01"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  environment         = var.environment
  acr_sku             = "Basic"
  tags                = local.tags
}

module "aks" {
  source = "../../../modules/azure/aks"

  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  environment         = var.environment
  subnet_id           = module.network.aks_subnet_id
  acr_id              = module.acr.acr_id
  tags                = local.tags
}

module "keyvault" {
  source = "../../../modules/azure/keyvault"

  keyvault_name       = "kv-devagent-01"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  environment         = var.environment
  tags                = local.tags
}

# User Assigned Identity for External Secrets Operator (Workload Identity)
resource "azurerm_user_assigned_identity" "eso" {
  name                = "dev-eso-identity"
  resource_group_name = module.network.resource_group_name
  location            = module.network.location
  tags                = local.tags
}

# Federated Identity Credential linking Managed Identity to Kubernetes ServiceAccount
resource "azurerm_federated_identity_credential" "eso" {
  name                      = "eso-federated-credential"
  audience                  = ["api://AzureADTokenExchange"]
  issuer                    = module.aks.oidc_issuer_url
  subject                   = "system:serviceaccount:external-secrets:external-secrets"
  user_assigned_identity_id = azurerm_user_assigned_identity.eso.id
}

# Standalone Access Policy granting ESO Identity GET/LIST secret access to Key Vault
resource "azurerm_key_vault_access_policy" "eso" {
  key_vault_id = module.keyvault.key_vault_id
  tenant_id    = azurerm_user_assigned_identity.eso.tenant_id
  object_id    = azurerm_user_assigned_identity.eso.principal_id

  secret_permissions = [
    "Get",
    "List"
  ]
}

# Grant AKS control plane identity Network Contributor role on the resource group
resource "azurerm_role_assignment" "aks_rg" {
  scope                = module.network.resource_group_id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.identity_principal_id
}

# Grant AKS kubelet identity Network Contributor role on the resource group
resource "azurerm_role_assignment" "kubelet_rg" {
  scope                = module.network.resource_group_id
  role_definition_name = "Network Contributor"
  principal_id         = module.aks.kubelet_identity.client_id == null ? null : module.aks.kubelet_identity.object_id
}





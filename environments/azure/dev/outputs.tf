output "aks_cluster_id" {
  description = "The ID of the AKS cluster."
  value       = module.aks.cluster_id
}

output "aks_cluster_name" {
  description = "The name of the AKS cluster."
  value       = module.aks.cluster_name
}

output "aks_oidc_issuer_url" {
  description = "The URL of the OpenID Connect identity provider issuer."
  value       = module.aks.oidc_issuer_url
}

output "aks_kubelet_identity" {
  description = "The kubelet identity configuration block."
  value       = module.aks.kubelet_identity
}

output "aks_fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = module.aks.fqdn
}

output "aks_node_resource_group" {
  description = "The auto-generated Resource Group containing the AKS agent node resources."
  value       = module.aks.node_resource_group
}

output "key_vault_id" {
  description = "The ID of the Key Vault."
  value       = module.keyvault.key_vault_id
}

output "key_vault_name" {
  description = "The name of the Key Vault."
  value       = module.keyvault.key_vault_name
}

output "key_vault_uri" {
  description = "The URI of the Key Vault for resource access."
  value       = module.keyvault.key_vault_uri
}

output "eso_identity_client_id" {
  description = "The client ID of the User Assigned Identity for the External Secrets Operator."
  value       = azurerm_user_assigned_identity.eso.client_id
}



output "cluster_id" {
  description = "The ID of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.id
}

output "cluster_name" {
  description = "The name of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.name
}

output "oidc_issuer_url" {
  description = "The URL of the OpenID Connect identity provider issuer."
  value       = azurerm_kubernetes_cluster.aks.oidc_issuer_url
}

output "kubelet_identity" {
  description = "The kubelet identity configuration block."
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0]
}

output "fqdn" {
  description = "The FQDN of the AKS cluster."
  value       = azurerm_kubernetes_cluster.aks.fqdn
}

output "node_resource_group" {
  description = "The auto-generated Resource Group containing the AKS agent node resources."
  value       = azurerm_kubernetes_cluster.aks.node_resource_group
}

output "identity_principal_id" {
  description = "The principal ID of the control plane User Assigned Identity."
  value       = azurerm_user_assigned_identity.aks.principal_id
}


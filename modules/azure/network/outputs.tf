output "resource_group_name" {
  description = "The name of the resource group containing the network resources"
  value       = azurerm_resource_group.network.name
}

output "location" {
  description = "The Azure region where resources are deployed"
  value       = azurerm_resource_group.network.location
}

output "vnet_id" {
  description = "The ID of the Virtual Network"
  value       = azurerm_virtual_network.vnet.id
}

output "aks_subnet_id" {
  description = "The ID of the subnet dedicated to AKS"
  value       = azurerm_subnet.aks.id
}

output "resource_group_id" {
  description = "The ID of the resource group."
  value       = azurerm_resource_group.network.id
}
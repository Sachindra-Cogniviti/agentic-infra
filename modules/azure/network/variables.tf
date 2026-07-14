variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the network resources."
}

variable "location" {
  type        = string
  description = "The Azure region where resources will be created."
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, prod) used for resource naming."
}

variable "vnet_cidr" {
  type        = string
  description = "The CIDR block for the virtual network."
}

variable "aks_subnet_cidr" {
  type        = string
  description = "The CIDR block for the AKS subnet."
}

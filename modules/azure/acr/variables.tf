variable "resource_group_name" {
  type        = string
  description = "The name of the target resource group where the container registry will be deployed."
}

variable "location" {
  type        = string
  description = "The Azure region (e.g., Central India, East US) where the Container Registry resources will reside."
}

variable "environment" {
  type        = string
  description = "The deployment stage environment name (e.g., dev, stage, prod) used for resource naming and categorization."
}

variable "acr_sku" {
  type        = string
  default     = "Basic"
  description = "The tier / SKU pricing model of the Azure Container Registry. Options include Basic, Standard, and Premium."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of key-value string pairs to apply metadata tracking, cost-allocation, and ownership labels to the resources."
}

variable "acr_name" {
  type        = string
  description = "The globally unique name of the Azure Container Registry (alphanumeric only)."
}
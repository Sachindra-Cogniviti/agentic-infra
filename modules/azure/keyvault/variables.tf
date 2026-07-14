variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Key Vault."
}

variable "location" {
  type        = string
  description = "The Azure region where the Key Vault will be created."
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, stage, prod) used for resource naming."
}

variable "keyvault_name" {
  type        = string
  description = "The name of the Key Vault. Must be globally unique."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resource."
}

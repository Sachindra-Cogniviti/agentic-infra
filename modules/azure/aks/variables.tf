variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the AKS cluster."
}

variable "location" {
  type        = string
  description = "The Azure region where the AKS cluster and resources will be created."
}

variable "environment" {
  type        = string
  description = "The environment name (e.g., dev, stage, prod) used for naming."
}

variable "subnet_id" {
  type        = string
  description = "The subnet ID where the AKS cluster nodes will be deployed (Azure CNI Overlay)."
}

variable "acr_id" {
  type        = string
  description = "The ID of the Azure Container Registry to attach with AcrPull role assignment."
}

variable "node_count" {
  type        = number
  default     = 1
  description = "The number of nodes in the system node pool."
}

variable "vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "The size of the Virtual Machines to use for the system node pool."
}

variable "tags" {
  type        = map(string)
  description = "A mapping of tags to assign to the resources."
}

variable "aks_service_principal_client_id" {
  description = "The client id for the AKS service principal."
  default     = ""
}

variable "aks_service_principal_client_secret" {
  description = "The client secret for the AKS service principal."
  default     = ""
}

variable "env_name" {
  description = "The environment for the AKS cluster."
  default     = "prod"
}

variable "cluster_name" {
  description = "The name for the AKS cluster."
  default     = "vibe-social-cluster"
}

variable "resource_group_name" {
  description = "Resource group name that is unique in your Azure subscription."
  default     = "vibe-social-resource-group"
}

variable "resource_group_location" {
  description = "Location of the resource group."
  default     = "westeurope"
}

variable "instance_type" {
  description = "The instance type for the AKS cluster."
  default     = "standard_d2_v2"
}

variable "node_count" {
  description = "The number of nodes for the AKS cluster."
  default     = "2"
}

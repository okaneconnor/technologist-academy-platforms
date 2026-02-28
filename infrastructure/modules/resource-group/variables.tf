variable "name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region to deploy the resource group into"
  type        = string
}

variable "environment" {
  description = "The environment name used for tagging"
  type        = string
  default     = "dev"
}

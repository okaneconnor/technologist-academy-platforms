variable "location" {
  description = "The Azure region to deploy resources into"
  type        = string
  default     = "uksouth"
}

variable "environment" {
  description = "The environment name (dev, test, prod)"
  type        = string
  default     = "dev"
}

variable "acr_login_server" {
  description = "Login server hostname of the Azure Container Registry (e.g. myacr.azurecr.io)"
  type        = string
}

variable "acr_id" {
  description = "Full resource ID of the existing Azure Container Registry — used to scope the AcrPull role assignment"
  type        = string
}

variable "feature_new_ui" {
  description = "Feature flag: set to 'true' to enable the new UI. Passed as an environment variable to the frontend container."
  type        = string
  default     = "false"
}

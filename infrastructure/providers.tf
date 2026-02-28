terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.0.0"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-academy-tfstate"
    storage_account_name = "academytfstate"
    container_name       = "tfstate"
    key                  = "academy-pipeline.terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
  # ARM_SUBSCRIPTION_ID, ARM_CLIENT_ID, ARM_CLIENT_SECRET, ARM_TENANT_ID
  # are read automatically from environment variables set in the pipeline.
}

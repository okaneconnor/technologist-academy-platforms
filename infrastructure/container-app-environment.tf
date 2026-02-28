resource "azurerm_container_app_environment" "container_app_environment" {
  name                = "cae-academy-${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }
}

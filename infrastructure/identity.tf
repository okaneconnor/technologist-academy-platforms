resource "azurerm_user_assigned_identity" "managed_identity" {
  name                = "id-academy-${var.environment}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
}

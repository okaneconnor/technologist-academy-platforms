module "resource_group" {
  source = "./modules/resource-group"

  name        = "rg-academy-${var.environment}"
  location    = var.location
  environment = var.environment
}

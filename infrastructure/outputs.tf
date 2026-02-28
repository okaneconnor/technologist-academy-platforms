output "resource_group_name" {
  value = module.resource_group.name
}

output "resource_group_id" {
  value = module.resource_group.id
}

output "key_vault_name" {
  description = "Name of the Key Vault — add secrets here in the portal before deploying container apps"
  value       = azurerm_key_vault.key_vault.name
}

output "key_vault_uri" {
  description = "URI of the Key Vault"
  value       = azurerm_key_vault.key_vault.vault_uri
}

output "frontend_url" {
  description = "Public URL of the frontend application"
  value       = "https://${azurerm_container_app.frontend.latest_revision_fqdn}"
}

output "backend_fqdn" {
  description = "Internal FQDN of the backend"
  value       = azurerm_container_app.backend.latest_revision_fqdn
}

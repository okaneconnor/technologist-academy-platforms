# ── Backend Container App ──────────────────────────────────────────────────────
# Internal only — not reachable from the public internet.
# Frontend reaches it via its internal FQDN within the environment.

resource "azurerm_container_app" "backend" {
  name                         = "ca-backend-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = module.resource_group.name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.managed_identity.id]
  }

  registry {
    server   = var.acr_login_server
    identity = azurerm_user_assigned_identity.managed_identity.id
  }

  template {
    min_replicas = 1
    max_replicas = 3

    container {
      name   = "backend"
      image  = "${var.acr_login_server}/backend:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }

  ingress {
    external_enabled = false
    target_port      = 8000
    transport        = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }

  depends_on = [azurerm_role_assignment.acr_pull]
}

# ── Frontend Container App ─────────────────────────────────────────────────────
# Publicly accessible. Reaches the backend via its internal FQDN.
# Terraform creates the backend first (due to the fqdn reference), then frontend.

resource "azurerm_container_app" "frontend" {
  name                         = "ca-frontend-${var.environment}"
  container_app_environment_id = azurerm_container_app_environment.container_app_environment.id
  resource_group_name          = module.resource_group.name
  revision_mode                = "Single"

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.managed_identity.id]
  }

  registry {
    server   = var.acr_login_server
    identity = azurerm_user_assigned_identity.managed_identity.id
  }

  template {
    min_replicas = 1
    max_replicas = 3

    container {
      name   = "frontend"
      image  = "${var.acr_login_server}/frontend:latest"
      cpu    = 0.25
      memory = "0.5Gi"

      env {
        name  = "BACKEND_URL"
        value = "https://${azurerm_container_app.backend.latest_revision_fqdn}"
      }

      env {
        name  = "FEATURE_NEW_UI"
        value = var.feature_new_ui
      }
    }
  }

  ingress {
    external_enabled = true
    target_port      = 3000
    transport        = "auto"

    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  tags = {
    environment = var.environment
    managed_by  = "terraform"
  }

  depends_on = [
    azurerm_role_assignment.acr_pull,
    azurerm_role_assignment.kv_secrets_user,
  ]
}

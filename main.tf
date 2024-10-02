resource "random_string" "storage_account_random_name" {
  length  = 24
  special = false
  upper   = false
}

locals {
  default_storage_account_name = random_string.storage_account_random_name.result
  storage_account_name         = var.storage_account_name != "" ? var.storage_account_name : local.default_storage_account_name

  allowed_roles = [
    "db58b8e5-c6ad-4a2a-8342-4190687cbf4a", # Storage Blob Delegator
    "ba92f5b4-2d11-453d-a403-e96b0029c9fe", # Storage Blob Data Contributor
    "2a2b9908-6ea1-4ae2-8e65-a410df84e7d1"  # Storage Blob Data Reader
  ]

  role_assignments = [
    for role in var.role_assignments : role if contains(local.allowed_roles, role)
  ]
}

resource "azurerm_storage_account" "this" {
  name                            = local.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_kind                    = var.account_kind
  account_tier                    = var.account_tier
  account_replication_type        = var.account_replication_type
  access_tier                     = var.access_tier
  # https_traffic_only_enabled      = var.enable_https_traffic_only
  min_tls_version                 = "TLS1_2"
  allow_nested_items_to_be_public = var.allow_nested_items_to_be_public
  sftp_enabled                    = var.enable_sftp
  is_hns_enabled                  = var.enable_hns
  nfsv3_enabled                   = var.enable_nfs
  public_network_access_enabled   = var.public_network_access_enabled

  dynamic "immutability_policy" {
    for_each = var.immutable_enabled == true ? [1] : []
    content {
      allow_protected_append_writes = true
      state                         = "Unlocked"
      period_since_creation_in_days = var.immutability_period
    }
  }
  dynamic "blob_properties" {
    for_each = var.enable_data_protection == true ? [1] : []
    content {
      versioning_enabled  = var.enable_versioning
      change_feed_enabled = var.enable_change_feed

      container_delete_retention_policy {
        days = 7
      }
      delete_retention_policy {
        days = var.retention_period
      }
      dynamic "restore_policy" {
        for_each = var.restore_policy_days != null ? [1] : []
        content {
          days = var.restore_policy_days
        }
      }
      dynamic "cors_rule" {
        for_each = var.cors_rules

        content {
          allowed_headers    = cors_rule.value["allowed_headers"]
          allowed_methods    = cors_rule.value["allowed_methods"]
          allowed_origins    = cors_rule.value["allowed_origins"]
          exposed_headers    = cors_rule.value["exposed_headers"]
          max_age_in_seconds = cors_rule.value["max_age_in_seconds"]
        }
      }
    }
  }

  network_rules {
    bypass                     = ["AzureServices"]
    ip_rules                   = var.ip_rules
    virtual_network_subnet_ids = var.sa_subnets
    default_action             = var.default_action

    private_link_access {
      endpoint_resource_id = "/subscriptions/3a9bae85-2f6e-47a1-a371-7ee3c84cf70b/providers/Microsoft.Security/datascanners/storageDataScanner"
      endpoint_tenant_id   = "bbe41032-8fce-4d42-bab5-44e21510886d"
    }
  }
}

resource "azurerm_storage_management_policy" "storage_account_policy" {
  count              = length(var.policy) > 0 ? 1 : 0
  storage_account_id = azurerm_storage_account.this.id

  dynamic "rule" {
    for_each = var.policy
    content {
      name    = rule.value.name
      enabled = true
      filters {
        prefix_match = rule.value.filters.prefix_match
        blob_types   = rule.value.filters.blob_types
      }
      actions {
        version {
          delete_after_days_since_creation = rule.value.actions.version_delete_after_days_since_creation
        }
      }
    }
  }
}

resource "azurerm_role_assignment" "this" {
  for_each             = toset(local.role_assignments)
  scope                = azurerm_storage_account.this.id
  role_definition_name = each.value
  principal_id         = var.managed_identity_object_id
}
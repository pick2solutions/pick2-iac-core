locals {
  recovery_vault_name = var.existing_recovery_vault_name != null ? var.existing_recovery_vault_name : azurerm_recovery_services_vault.vault[0].name
}

## ------
## Storage Account
## ------
resource "azurerm_storage_account" "account" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  blob_properties {
    delete_retention_policy {
      days = var.delete_retention_days
    }
  }
}

## ------
## File Share
## ------
resource "azurerm_storage_share" "file_share" {
  name               = var.file_share_name
  storage_account_id = azurerm_storage_account.account.id
  quota              = var.file_share_quota
}

## ------
## Backup Services Vault
## ------
resource "azurerm_recovery_services_vault" "vault" {
  count               = var.existing_recovery_vault_name == null ? 1 : 0
  name                = "${var.storage_account_name}-vault"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = var.recovery_vault_sku
  soft_delete_enabled = true
}


## ------
## Register Storage Account with Backup Service
## ------
resource "azurerm_backup_container_storage_account" "protection_container" {
  resource_group_name = var.resource_group_name
  recovery_vault_name = local.recovery_vault_name
  storage_account_id  = azurerm_storage_account.account.id
}


## ------
## Create Backup Policy
## ------
resource "azurerm_backup_policy_file_share" "fileshare_backup" {
  name                = "${var.storage_account_name}-backup-policy"
  resource_group_name = var.resource_group_name
  recovery_vault_name = local.recovery_vault_name

  backup {
    frequency = var.backup_frequency
    time      = var.backup_time
  }

  retention_daily {
    count = var.retention_daily_count
  }
}

## ------
## Protect File Share
## ------
resource "azurerm_backup_protected_file_share" "frame_file_backup" {
  resource_group_name       = var.resource_group_name
  recovery_vault_name       = local.recovery_vault_name
  source_storage_account_id = azurerm_backup_container_storage_account.protection_container.storage_account_id
  source_file_share_name    = azurerm_storage_share.file_share.name
  backup_policy_id          = azurerm_backup_policy_file_share.fileshare_backup.id
}
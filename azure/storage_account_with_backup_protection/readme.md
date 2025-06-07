# Azure Storage Account with Backup Protection

## Description

This Terraform module provisions an Azure Storage Account with a file share and configures Azure Backup protection for the file share.  
It can create a new Recovery Services Vault or use an existing one, based on input variables.

---

## Usage

```hcl
module "storage_account_with_backup_protection" {
  source = "./azure/storage_account_with_backup_protection"

  storage_account_name         = "examplestorageacct"
  resource_group_name          = "example-rg"
  location                     = "eastus"
  file_share_name              = "examplefileshare"
  file_share_quota             = 100
  account_tier                 = "Standard"
  account_replication_type     = "LRS"
  delete_retention_days        = 7
  recovery_vault_sku           = "Standard"

  # Optional: Use an existing Recovery Services Vault
  # existing_recovery_vault_name = "my-existing-vault"
}
```

---

## Variables

| Name                         | Type   | Description                                                                 | Default     |
|------------------------------|--------|-----------------------------------------------------------------------------|-------------|
| storage_account_name         | string | The name of the storage account.                                            | n/a         |
| resource_group_name          | string | The name of the resource group.                                             | n/a         |
| location                     | string | The Azure region for resources.                                             | n/a         |
| file_share_name              | string | The name of the file share.                                                 | n/a         |
| file_share_quota             | number | The quota for the file share in GB.                                         | 100         |
| account_tier                 | string | The performance tier of the storage account (Standard, Premium).            | Standard    |
| account_replication_type     | string | The replication type (LRS, GRS, RA-GRS).                                    | LRS         |
| delete_retention_days        | number | Number of days to retain deleted blobs.                                     | 7           |
| recovery_vault_sku           | string | SKU for the Recovery Services Vault (Standard, Premium).                    | Standard    |
| existing_recovery_vault_name | string | (Optional) Name of an existing Recovery Services Vault to use. If not set, a new vault is created. | null        |

---

## Outputs

_None defined yet. Add outputs as needed._

---

## Resources Created

- `azurerm_storage_account`
- `azurerm_storage_share`
- `azurerm_recovery_services_vault` (optional)
- `azurerm_backup_container_storage_account`
- `azurerm_backup_policy_file_share`
- `azurerm_backup_protected_file_share`

---

## Notes

- If `existing_recovery_vault_name` is provided, the module will use that vault instead of creating a new one.
- The backup policy is set to daily at 23:00 with a retention of 10 days by default. Adjust as needed in the module.

---
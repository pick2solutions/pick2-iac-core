variable "storage_account_name" {
  type = string
  description = "The name of the storage account."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group where the storage account will be created." 
}

variable "location" {
  type = string
  description = "The Azure region where the storage account will be created."
}

variable "file_share_name" {
  type = string
  description = "The name of the file share to be created in the storage account."
}

variable "existing_recovery_vault_name" {
  description = "Name of an existing Recovery Services Vault to use. If not set, a new vault will be created."
  type        = string
  default     = null
}


variable "file_share_quota" {
  type = number
  description = "The quota for the file share in GB."
  default = 100
}

variable "account_tier" {
  type = string
  description = "The performance tier of the storage account (e.g., Standard, Premium)."
  default = "Standard"
}

variable "recovery_vault_sku" {
  type = string
  description = "The SKU for the Recovery Services Vault (e.g., Standard, Premium)."
  default = "Standard"
}

variable "account_replication_type" {
  type = string
  description = "The replication type for the storage account (e.g., LRS, GRS, RA-GRS)."
  default = "LRS"
}

variable "delete_retention_days" {
  type = number
  description = "The number of days to retain deleted blobs in the storage account."
  default = 7
}
output "storage_account_id" {
  value       = azurerm_storage_account.this.id
  description = "The storage account Resource ID. "
}

output "storage_account_name" {
  value       = var.storage_account_name
  description = "The storage account name."
}

output "primary_access_key" {
  value       = azurerm_storage_account.storage_account.primary_access_key
  description = "The primary access key for the storage account."
  sensitive   = true
}

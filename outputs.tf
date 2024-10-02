output "storageaccount_id" {
  value       = azurerm_storage_account.this.id
  description = "The storage account Resource ID. "
}

output "storageaccount_name" {
  value       = var.storage_account_name
  description = "The storage account name."
}
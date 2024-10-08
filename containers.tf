resource "azurerm_storage_container" "this" {
  for_each              = { for container in var.containers : container.name => container }
  storage_account_name  = azurerm_storage_account.this.name
  name                  = each.value.name
  container_access_type = each.value.access_type
}
# terraform-module-storage-account
A Terraform module for the creation of storage accounts

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_container.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_container) | resource |
| [azurerm_storage_management_policy.storage_account_policy](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_management_policy) | resource |
| [azurerm_storage_table.tables](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_table) | resource |
| [random_string.storage_account_random_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_access_tier"></a> [access\_tier](#input\_access\_tier) | (Optional) Defines the access tier for BlobStorage and StorageV2 accounts. | `string` | `"Hot"` | no |
| <a name="input_account_kind"></a> [account\_kind](#input\_account\_kind) | Defines the Kind of account. Valid options are Storage, StorageV2 and BlobStorage. | `string` | n/a | yes |
| <a name="input_account_replication_type"></a> [account\_replication\_type](#input\_account\_replication\_type) | (Required) Defines the type of replication to use for this storage account. | `string` | `"LRS"` | no |
| <a name="input_account_tier"></a> [account\_tier](#input\_account\_tier) | Defines the Tier to use for this storage account. Valid options are Standard and Premium. | `string` | `"Standard"` | no |
| <a name="input_allow_nested_items_to_be_public"></a> [allow\_nested\_items\_to\_be\_public](#input\_allow\_nested\_items\_to\_be\_public) | (Optional) Allow or disallow public access to all blobs or containers in the storage account. | `bool` | `false` | no |
| <a name="input_containers"></a> [containers](#input\_containers) | List of Storage Containers | <pre>list(object({<br>    name        = string<br>    access_type = string<br>  }))</pre> | `[]` | no |
| <a name="input_cors_rules"></a> [cors\_rules](#input\_cors\_rules) | (Optional) A list of Cors Rule blocks. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#cors_rule | <pre>list(object({<br>    allowed_headers    = list(string)<br>    allowed_methods    = list(string)<br>    allowed_origins    = list(string)<br>    exposed_headers    = list(string)<br>    max_age_in_seconds = number<br>  }))</pre> | `[]` | no |
| <a name="input_default_action"></a> [default\_action](#input\_default\_action) | (Optional) Network rules default action | `string` | `"Deny"` | no |
| <a name="input_enable_change_feed"></a> [enable\_change\_feed](#input\_enable\_change\_feed) | n/a | `bool` | `false` | no |
| <a name="input_enable_data_protection"></a> [enable\_data\_protection](#input\_enable\_data\_protection) | (Optional) Boolean flag which controls if Data Protection are enabled for Blob storage, see https://docs.microsoft.com/en-us/azure/storage/blobs/versioning-overview for more information. | `bool` | `false` | no |
| <a name="input_enable_hns"></a> [enable\_hns](#input\_enable\_hns) | (Optional) Boolean flag which controls if the hierarchical namespace is enabled for this storage account, required for SFTP support. See https://learn.microsoft.com/en-gb/azure/storage/blobs/data-lake-storage-namespace for more information. | `bool` | `false` | no |
| <a name="input_enable_https_traffic_only"></a> [enable\_https\_traffic\_only](#input\_enable\_https\_traffic\_only) | (Optional) Boolean flag which forces HTTPS if enabled, see https://docs.microsoft.com/en-us/azure/storage/storage-require-secure-transfer/ for more information. | `bool` | `true` | no |
| <a name="input_enable_nfs"></a> [enable\_nfs](#input\_enable\_nfs) | (Optional) Boolean flag which controls if NFS is enabled for this storage account, Requires `enable_nfs` to be `true`. | `bool` | `false` | no |
| <a name="input_enable_sftp"></a> [enable\_sftp](#input\_enable\_sftp) | (Optional) Boolean flag which controls if SFTP functionality is enabled for this storage account, Requires `enable_hns` to be `true`. See https://learn.microsoft.com/en-us/azure/storage/blobs/secure-file-transfer-protocol-support for more information. | `bool` | `false` | no |
| <a name="input_enable_versioning"></a> [enable\_versioning](#input\_enable\_versioning) | Whether to enable versioning when data protection has been enabled. Defaults to true. | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | The deployment environment | `string` | n/a | yes |
| <a name="input_immutability_period"></a> [immutability\_period](#input\_immutability\_period) | The immutability period for the blobs in the container since the policy creation, in days. | `number` | `"1"` | no |
| <a name="input_immutable_enabled"></a> [immutable\_enabled](#input\_immutable\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | (Optional) List of public IP addresses which will have access to storage account. | `list(string)` | `[]` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. | `string` | `"uksouth"` | no |
| <a name="input_managed_identity_object_id"></a> [managed\_identity\_object\_id](#input\_managed\_identity\_object\_id) | (Optional) Object Id for a Managed Identity to assign roles to, scoped to this storage account. | `string` | `""` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | Storage Account Managment Policy | <pre>list(object({<br>    name = string<br>    filters = object({<br>      prefix_match = list(string)<br>      blob_types   = list(string)<br>    })<br>    actions = object({<br>      version_delete_after_days_since_creation = number<br>    })<br>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether the public network access is enabled? Defaults to true | `bool` | `true` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group to deploy to. | `string` | n/a | yes |
| <a name="input_restore_policy_days"></a> [restore\_policy\_days](#input\_restore\_policy\_days) | Specifies the number of days that the blob can be restored, between 1 and 365 days. | `number` | `null` | no |
| <a name="input_retention_period"></a> [retention\_period](#input\_retention\_period) | (Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 365 | `number` | `7` | no |
| <a name="input_role_assignments"></a> [role\_assignments](#input\_role\_assignments) | (Optional) List of roles to assign to the provided Managed Identity, scoped to this storage account. | `list(string)` | `[]` | no |
| <a name="input_sa_subnets"></a> [sa\_subnets](#input\_sa\_subnets) | (Optional) List of subnet ID's which will have access to this storage account. | `list(string)` | `[]` | no |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | (Required) Specifies the name of the storage account. | `any` | n/a | yes |
| <a name="input_tables"></a> [tables](#input\_tables) | List of Storage Tables | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The primary access key for the storage account. |
| <a name="output_storageaccount_id"></a> [storageaccount\_id](#output\_storageaccount\_id) | The storage account Resource ID. |
| <a name="output_storageaccount_name"></a> [storageaccount\_name](#output\_storageaccount\_name) | The storage account name. |
<!-- END_TF_DOCS -->
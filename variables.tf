variable "env" {
  type        = string
  description = "The deployment environment"
}

variable "storage_account_name" {
  description = "(Required) Specifies the name of the storage account."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group to deploy to."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists."
  default     = "uksouth"
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are Storage, StorageV2 and BlobStorage."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "(Required) Defines the type of replication to use for this storage account."
  default     = "LRS"
}

variable "access_tier" {
  type        = string
  description = "(Optional) Defines the access tier for BlobStorage and StorageV2 accounts."
  default     = "Hot"
}

variable "enable_data_protection" {
  type        = bool
  description = "(Optional) Boolean flag which controls if Data Protection are enabled for Blob storage, see https://docs.microsoft.com/en-us/azure/storage/blobs/versioning-overview for more information."
  default     = false
}

variable "allow_nested_items_to_be_public" {
  type        = bool
  description = "(Optional) Allow or disallow public access to all blobs or containers in the storage account."
  default     = false
}

variable "enable_hns" {
  description = "(Optional) Boolean flag which controls if the hierarchical namespace is enabled for this storage account, required for SFTP support. See https://learn.microsoft.com/en-gb/azure/storage/blobs/data-lake-storage-namespace for more information."
  default     = false
}

variable "enable_nfs" {
  description = "(Optional) Boolean flag which controls if NFS is enabled for this storage account, Requires `enable_nfs` to be `true`."
  default     = false
}

variable "enable_sftp" {
  description = "(Optional) Boolean flag which controls if SFTP functionality is enabled for this storage account, Requires `enable_hns` to be `true`. See https://learn.microsoft.com/en-us/azure/storage/blobs/secure-file-transfer-protocol-support for more information."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "(Optional) Whether the public network access is enabled? Defaults to true"
  default     = true
}

variable "ip_rules" {
  type        = list(string)
  description = "(Optional) List of public IP addresses which will have access to storage account."
  default     = []
}

variable "sa_subnets" {
  type        = list(string)
  description = "(Optional) List of subnet ID's which will have access to this storage account."
  default     = []
}

variable "default_action" {
  description = "(Optional) Network rules default action"
  default     = "Deny"
}

variable "managed_identity_object_id" {
  type        = string
  description = "(Optional) Object Id for a Managed Identity to assign roles to, scoped to this storage account."
  default     = ""
}

variable "role_assignments" {
  type        = list(string)
  description = "(Optional) List of roles to assign to the provided Managed Identity, scoped to this storage account."
  default     = []
}

// Management Lifecycle
variable "policy" {
  type = list(object({
    name = string
    filters = object({
      prefix_match = list(string)
      blob_types   = list(string)
    })
    actions = object({
      version_delete_after_days_since_creation = number
    })
  }))
  description = "Storage Account Managment Policy"
  default     = []
}

variable "containers" {
  type = list(object({
    name        = string
    access_type = string
  }))
  description = "List of Storage Containers"
  default     = []
}

variable "tables" {
  type        = list(string)
  description = "List of Storage Tables"
  default     = []
}

variable "cors_rules" {
  type = list(object({
    allowed_headers    = list(string)
    allowed_methods    = list(string)
    allowed_origins    = list(string)
    exposed_headers    = list(string)
    max_age_in_seconds = number
  }))
  description = "(Optional) A list of Cors Rule blocks. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account#cors_rule"
  default     = []
}

variable "enable_change_feed" {
  type    = bool
  default = false
}

variable "enable_versioning" {
  default     = true
  description = "Whether to enable versioning when data protection has been enabled. Defaults to true."
  type        = bool
}

variable "immutable_enabled" {
  type    = bool
  default = false
}

variable "immutability_period" {
  type        = number
  default     = "1"
  description = "The immutability period for the blobs in the container since the policy creation, in days."
}

variable "restore_policy_days" {
  type        = number
  default     = null
  description = "Specifies the number of days that the blob can be restored, between 1 and 365 days."
}

variable "retention_period" {
  type        = number
  default     = 7
  description = "(Optional) Specifies the number of days that the blob should be retained, between 1 and 365 days. Defaults to 365"
}
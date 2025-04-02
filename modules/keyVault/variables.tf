variable "hub_keyvaults" {
  description = "Map of Key Vaults to be created with configuration details"
  type = map(object({
    location_key                  = string
    index                         = number
    sku_name                      = string
    public_network_access_enabled = bool
    runner_ip_ranges              = list(string)
    deploy_user_kv_admin_principal_id = string
  }))
}

variable "resource_group_name" {
  description = "Map of locations to their resource group details"
  type = map(object({
    location = string
    rg       = string
  }))
}

variable "tenant_id" {
  description = "Azure Active Directory Tenant ID"
  type        = string
}

variable "pdns_subscription_id" {
  description = "Subscription ID where the private DNS zone is located"
  type        = string
}

variable "naming" {
}

variable "remote_virtual_networks" {
}

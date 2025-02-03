variable "vnets" {
  description = "The virtual networks."
  type        = map(object({
    resource_group_name = string
    location            = string
    vnet_name           = string
    vnet_address_space  = list(string)
    enable_encryption    = bool
    subnets             = map(object({
      address_prefixes                = list(string)
      default_outbound_access_enabled = bool
    }))
  }))
}
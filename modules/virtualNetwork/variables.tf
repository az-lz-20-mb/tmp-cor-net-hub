variable "vnets" {
  description = "The virtual networks."
  type        = map(object({
    vnet_address_space  = list(string)
    enable_encryption    = bool
    subnets             = map(object({
      address_prefixes                = list(string)
      default_outbound_access_enabled = bool
    }))
  }))
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resources"
}

variable "name" {
  type        = string
  description = "The name of the virtual network"
}

variable "subnet_name" {
  type        = string
  description = "The name of the subnet"
}
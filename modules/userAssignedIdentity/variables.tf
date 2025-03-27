variable "hub_virtual_networks" {
  type = map(object({
    index             = string
    location          = string

    firewall = optional(object({
      subnet_address_prefix = string
      sku_name              = string
      sku_tier              = string
      firewall_policy = object({
        enable_uami = bool
        dns = object({
          proxy_enabled = bool
        })
      })
    }))
  }))
}


variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
  }))
}

variable "naming" {
}

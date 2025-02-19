variable "hub_virtual_networks" {
  type = map(object({
    name            = string
    address_space   = list(string)
    location        = string
    route_table_name = string
    routing_address_space = list(string)

    firewall = optional(object({
      subnet_address_prefix = string
      name                  = string
      sku_name              = string
      sku_tier              = string
      firewall_policy = object({
        name = string
        dns = object({
          proxy_enabled = bool
        })
      })
    }))

    subnets = map(object({
      name             = string
      address_prefixes = list(string)
      route_table      = optional(object({
        assign_generated_route_table = bool
      }))
    }))
  }))
}

variable "resource_group_name" {
  description = "The name of the resource group in which the virtual network will be created"
  type        = string
}
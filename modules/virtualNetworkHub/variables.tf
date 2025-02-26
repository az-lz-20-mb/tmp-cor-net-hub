variable "hub_virtual_networks" {
  type = map(object({
    index            = string
    address_space   = list(string)
    routing_address_space = list(string)

    firewall = optional(object({
      subnet_address_prefix = string
      sku_name              = string
      sku_tier              = string
      firewall_policy = object({
        dns = object({
          proxy_enabled = bool
        })
      })
    }))

    subnets = map(object({
      index            = string
      address_prefixes = list(string)
      route_table      = optional(object({
        assign_generated_route_table = bool
      }))
    }))
  }))
}
variable "resource_group_name" {
  type = map(object({
    rg = string
    location = string
    short_location = string
  }))
}

# variable "firewall_name" {
#   description = "The name of the firewall"
#   type        = map(object({
#     name = string
#   }))
# }

# variable "firewall_policy_name" {
#   description = "The name of the firewall policy"
#   type        = map(object({
#     name = string
#   }))
# }

# variable "route_table_name" {
#   description = "The name of the route table"
#   type        = map(object({
#     name = string
#   }))
# }

# variable "subnet_name" {
#   description = "The name of the subnet"
#   type        = map(object({
#     name = string
#   }))
# }

# variable "hub_name" {
#   description = "The name of the hub"
#   type        = map(object({
#     name = string
#   }))
# }


variable "naming" {
  description = "Naming convention object"
  type        = map(object({
    virtual_network = map(string)
    subnet          = map(string)
    route_table     = map(string)
    firewall        = map(string)
    firewall_policy = map(string)
  })
}
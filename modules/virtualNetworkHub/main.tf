module "hubnetworking_hub" {
  source = "git::https://github.com/az-lz-20-mb/mod-avm-ptn-hubnetworking.git"

  hub_virtual_networks = {
    for key, hub in var.hub_virtual_networks : key => {
      name                            = var.naming.virtual_network[hub.index].name
      address_space                   = hub.address_space
      location                        = lookup(var.resource_group_name[hub.index], "location")
      resource_group_name             = lookup(var.resource_group_name[hub.index], "rg")
      resource_group_creation_enabled = false
      resource_group_lock_enabled     = false
      mesh_peering_enabled            = true
      route_table_name                = var.naming.route_table[hub.index].name
      routing_address_space           = hub.routing_address_space

      firewall = hub.firewall != null ? {
        subnet_address_prefix = hub.firewall.subnet_address_prefix
        name                  = var.naming.firewall[hub.index].name
        sku_name              = hub.firewall.sku_name
        sku_tier              = hub.firewall.sku_tier
        firewall_policy = {
          name = var.naming.firewall_policy[hub.index].name
          dns = {
            proxy_enabled = hub.firewall.firewall_policy.dns.proxy_enabled
          }
        }
      } : null

      subnets = {
        for subnet_key, subnet in hub.subnets : subnet_key => {
          name             = var.naming.subnet[subnet.index].name
          address_prefixes = subnet.address_prefixes
          route_table      = subnet.route_table
        }
      }
    }
  }
}
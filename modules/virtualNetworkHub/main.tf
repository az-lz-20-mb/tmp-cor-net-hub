module "hubnetworking_hub" {
  source = "git::https://github.com/az-lz-20-mb/mod-avm-ptn-hubnetworking.git"

  hub_virtual_networks = {
    for key, hub in var.hub_virtual_networks : key => {
      name                            = "${lookup(var.naming[hub.location].virtual_network, "name")}-${hub.index}"
      address_space                   = hub.address_space
      location                        = lookup(var.resource_group_name[hub.location], "location")
      resource_group_name             = lookup(var.resource_group_name[hub.location], "rg")
      resource_group_creation_enabled = false
      resource_group_lock_enabled     = false
      mesh_peering_enabled            = true
      route_table_name                = "${lookup(var.naming[hub.location].route_table, "name")}-${hub.index}"
      routing_address_space           = hub.routing_address_space

      firewall = hub.firewall != null ? {
        subnet_address_prefix = hub.firewall.subnet_address_prefix
        name                  = "${lookup(var.naming[hub.location].firewall, "name")}-${hub.index}"
        sku_name              = hub.firewall.sku_name
        sku_tier              = hub.firewall.sku_tier
        firewall_policy = {
          name = "${lookup(var.naming[hub.location].firewall_policy, "name")}-${hub.index}"
          dns = {
            proxy_enabled = hub.firewall.firewall_policy.dns.proxy_enabled
          }
        }
      } : null

      subnets = {
        for subnet_key, subnet in hub.subnets : subnet_key => {
          name             = "${lookup(var.naming[hub.location].subnet, "name")}-${subnet.index}"
          address_prefixes = subnet.address_prefixes
          route_table      = subnet.route_table
        }
      }
    }
  }
}

output "hub_vnet_ids" {
  value = { for k, v in module.hubnetworking_hub : k => v.virtual_networks }
}

output "snet_route_table_ids" {
  value = { for k, v in module.hubnetworking_hub : k => v.hub_route_tables_user_subnets }
}

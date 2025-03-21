module "hubnetworking_hub" {
  source = "git::https://github.com/az-lz-20-mb/mod-avm-ptn-hubnetworking.git"

  hub_virtual_networks = {
    for key, hub in var.hub_virtual_networks : key => {
      name                            = "${lookup(var.naming.lz_caf_names[hub.location].virtual_network, "name")}-${var.naming.hub_resource_suffix}-${hub.index}"
      address_space                   = hub.address_space
      location                        = lookup(var.resource_group_name[hub.location], "location")
      resource_group_name             = lookup(var.resource_group_name[hub.location], "rg")
      resource_group_creation_enabled = false
      resource_group_lock_enabled     = false
      mesh_peering_enabled            = true
      route_table_name                = "${module.naming.lz_custom_caf_naming.hub_resource[hub.location]["route_table"]}-${hub.index}"
      routing_address_space           = hub.routing_address_space

      firewall = hub.firewall != null ? {
        subnet_address_prefix = hub.firewall.subnet_address_prefix
        name                  = "${module.naming.lz_custom_caf_naming.hub_resource[hub.location]["firewall"]}-${hub.index}"
        sku_name              = hub.firewall.sku_name
        sku_tier              = hub.firewall.sku_tier
        firewall_policy = {
          name = "${module.naming.lz_custom_caf_naming.hub_resource[hub.location]["firewall_policy"]}-${hub.index}"
          dns = {
            proxy_enabled = hub.firewall.firewall_policy.dns.proxy_enabled
          }
        }
      } : null

      subnets = {
        for subnet_key, subnet in hub.subnets : subnet_key => {
          name             = "${module.naming.lz_custom_caf_naming.hub_resource[hub.location]["subnet"]}-${subnet.index}"
          address_prefixes = subnet.address_prefixes
          route_table      = subnet.route_table
        }
      }
    }
  }
}

output "virtual_networks" {
  value = module.hubnetworking_hub.virtual_networks
}

output "hub_route_tables_user_subnets" {
  value = module.hubnetworking_hub.hub_route_tables_user_subnets
}
module "hubnetworking_hub" {
  source = "git::https://github.com/az-lz-20-mb/mod-avm-ptn-hubnetworking.git"

  hub_virtual_networks = {
    for key, hub in var.hub_virtual_networks : key => {
      name                            = "${var.hub_name}-${hub.index}"
      address_space                   = hub.address_space
      location                        = hub.location
      resource_group_name             = var.resource_group_name
      resource_group_creation_enabled = false
      resource_group_lock_enabled     = false
      mesh_peering_enabled            = true
      route_table_name                = "${var.route_table_name}-${hub.index}"
      routing_address_space           = hub.routing_address_space

      firewall = hub.firewall != null ? {
        subnet_address_prefix = hub.firewall.subnet_address_prefix
        name                  = "${var.firewall_name}-${hub.index}"
        sku_name              = hub.firewall.sku_name
        sku_tier              = hub.firewall.sku_tier
        firewall_policy = {
          name = "${var.firewall_policy_name}-${hub.index}"
          dns = {
            proxy_enabled = hub.firewall.firewall_policy.dns.proxy_enabled
          }
        }
      } : null

      subnets = {
        for subnet_key, subnet in hub.subnets : subnet_key => {
          name             = "${var.subnet_name}-${subnet.index}"
          address_prefixes = subnet.address_prefixes
          route_table      = subnet.route_table
        }
      }
    }
  }
}
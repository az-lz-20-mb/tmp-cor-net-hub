module "vnet_spoke" {
  for_each = var.spokes
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.7.1"

  name                = "${lookup(var.naming[each.value.location].virtual_network, "name")}-${each.value.index}"
  address_space       = each.value.address_space
  resource_group_name = lookup(var.resource_group_name[each.value.location], "rg")
  location            = lookup(var.resource_group_name[each.value.location], "location")

  peerings = {
    for peering_key, peering in each.value.peerings : peering_key => {
        # name                                 = "${lookup(var.naming[each.value.location].virtual_network_peering, "name")}-${each.value.index}"
        name                                  = peering.name  
        remote_virtual_network_resource_id   = lookup(var.remote_virtual_networks[each.key], "id")
        # remote_virtual_network_resource_id   = var.remote_virtual_network_resource_id
        allow_forwarded_traffic              = peering.allow_forwarded_traffic
        allow_gateway_transit                = peering.allow_gateway_transit
        allow_virtual_network_access         = peering.allow_virtual_network_access
        use_remote_gateways                  = peering.use_remote_gateways
        create_reverse_peering               = peering.create_reverse_peering
        reverse_name                         = peering.reverse_name
        reverse_allow_forwarded_traffic      = peering.reverse_allow_forwarded_traffic
        reverse_allow_gateway_transit        = peering.reverse_allow_gateway_transit
        reverse_allow_virtual_network_access = peering.reverse_allow_virtual_network_access
        reverse_use_remote_gateways          = peering.reverse_use_remote_gateways
    }
  }
  subnets = {
    for subnet_key, subnet in each.value.subnets : subnet_key => {
        name             = "${lookup(var.naming[each.value.location].subnet, "name")}-${subnet.index}"
        address_prefixes = subnet.address_prefixes
        route_table = {
          id = lookup(var.snet_route_table[each.key], "id")
      }
    }
  }
}


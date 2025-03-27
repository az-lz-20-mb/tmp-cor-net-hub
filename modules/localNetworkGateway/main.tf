module "local_network_gateway" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-localnetworkgateway.git"  
  for_each = var.local_network_gateways

  # Resource group variables
  location           = lookup(var.resource_group_name[each.value.location], "location") //to cahnge
  name               = "${var.naming.lz_custom_names[each.value.location].local_network_gateway_name}-${each.value.index}"

  # Local network gateway variables
  resource_group_name = lookup(var.resource_group_name[each.value.location], "rg") 
  gateway_address     = each.value.gateway_address
  address_space       = each.value.address_space

  # BGP settings (optional)
  bgp_settings     = each.value.bgp_settings
}
module "vgw" {
  source             ="git::https://github.com/Azure/terraform-azurerm-avm-ptn-vnetgateway.git"

  for_each            = var.virtual_network_gateways

  name                = "${lookup(var.naming.lz_custom_names[each.value.location_key].virtual_network_gateway_name)}-${each.value.index}"
  location            = lookup(var.remote_virtual_networks[each.key], "location")
  sku                 = each.value.sku
  type                = each.value.type
  virtual_network_id  = lookup(var.remote_virtual_networks[each.key], "id")

  subnet_address_prefix   = each.value.subnet_address_prefix

  ip_configurations   = each.value.ip_configurations

  local_network_gateways = each.value.local_network_gateways
}
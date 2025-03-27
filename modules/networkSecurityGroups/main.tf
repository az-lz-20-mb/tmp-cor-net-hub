module "nsg" {
  source   = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-networksecuritygroup.git"

  for_each            = var.network_security_groups
  name                = "${var.naming.lz_custom_names[each.value.location_key].hub_network_security_group_name}-${each.value.index}"
  resource_group_name = lookup(var.resource_group_name[each.value.location_key], "rg")
  location            = lookup(var.resource_group_name[each.value.location_key], "location")

  security_rules      = each.value.security_rules
}
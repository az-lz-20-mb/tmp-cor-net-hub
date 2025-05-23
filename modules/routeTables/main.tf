module "route_tables" {
  source           = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-routetable.git"
  for_each            = var.route_tables
  name                = "${var.naming.lz_custom_names[each.value.location_key].hub_route_table_name}-${each.value.index}"
  resource_group_name = lookup(var.resource_group_name[each.value.location_key], "rg")
  location            = lookup(var.resource_group_name[each.value.location_key], "location")

  routes              = each.value.routes
#   subnet_resource_ids = each.value.subnet_resource_ids
}
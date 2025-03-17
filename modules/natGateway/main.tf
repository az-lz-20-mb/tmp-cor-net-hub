module "natgateway" {
  source             = "git::https://github.com/Azure/terraform-azurerm-avm-res-network-natgateway.git"

  for_each            = var.nat_gateways
  name                = "${lookup(var.naming[each.value.location_key].nat_gateway, "name")}-${each.value.index}"
  resource_group_name = lookup(var.resource_group_name[each.value.location_key], "rg")
  location            = lookup(var.resource_group_name[each.value.location_key], "location")

  public_ips          = each.value.public_ips
  subnet_associations = each.value.subnet_associations
}
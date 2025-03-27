module "uami" {
  source   = "git::https://github.com/Azure/terraform-azurerm-avm-res-managedidentity-userassignedidentity.git"
  for_each = { 
    for k, v in var.hub_virtual_networks : k => v 
    if v.firewall.firewall_policy.enable_uami == true
  }

  location            = lookup(var.resource_group_name[v.location], "location") //to cahnge
  name                = "${module.naming.custim_lz_names.fwp_user_assigned_identity_name}-${v.index}"
  resource_group_name = lookup(var.resource_group_name[v.location], "rg") 
}
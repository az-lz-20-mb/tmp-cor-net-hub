module "ddosprotectionplan" {
  source = "https://github.com/Azure/terraform-azurerm-avm-res-network-ddosprotectionplan.git"
  for_each = { for k, v in var.ddos_protection_plans : k => v if v.enable }

  resource_group_name =  lookup(var.resource_group_name[each.value.location], "rg") 
  name                = module.naming.network_ddos_protection_plan[k].name
  location            =  lookup(var.resource_group_name[each.value.location], "location") 
}
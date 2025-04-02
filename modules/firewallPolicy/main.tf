module "firewall_policy" {
  source = "https://github.com/Azure/terraform-azurerm-avm-res-network-firewallpolicy.git"
  for_each = var.firewall_policies
  name                            = module.naming.lz_custom_names.firewall_policy_name
  location                        = lookup(var.resource_group_name[each.value.location], "location")
  resource_group_name             = lookup(var.resource_group_name[each.value.location], "rg")
  tier                            = "Standard"

  firewall_policy_dns = {
    proxy_enabled                 = each.value.proxy_enabled
  }

  firewall_policy_tls_certificate = {
    key_vault_secret_id           = module.keyvault.keys.cmk_for_firewall_policy.key_id
    name                          = each.value.tls_inspecion_name
  }
  firewall_policy_intrusion_detection = {
    mode                          = each.value.firewall_policy_intrusion_detection.mode
    private_ranges                = each.value.firewall_policy_intrusion_detection.private_ranges
    signature_overrides           = each.value.firewall_policy_intrusion_detection.signature_overrides
    traffic_bypass                = each.value.firewall_policy_intrusion_detection.traffic_bypass
  }
}
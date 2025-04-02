module "keyvault" {
  source = "git::https://github.com/Azure/terraform-azurerm-avm-res-keyvault-vault.git"
  for_each                      = var.hub_keyvaults

  name                          = "${var.naming.lz_custom_names[each.value.location_key].key_vault_name}-${each.value.index}"
  sku_name                      = each.value.sku_name
  location                      = lookup(var.resource_group_name[each.value.location], "location")
  resource_group_name           = lookup(var.resource_group_name[each.value.location], "rg")


  tenant_id                     = var.tenant_id
  public_network_access_enabled = each.value.public_network_access_enabled
  private_endpoints = {
    primary = {
      name                                  = "pe-${var.naming.lz_custom_names[each.value.location_key].key_vault_name}-${each.value.index}"
      private_dns_zone_resource_ids         = ["/subscirpitons/${var.pdns_subscription_id}/resourceGroups/${lookup(var.remote_virtual_networks["gwc"], "rg")}/providers/Microsoft.Network/privateDnsZones/privatelink.vaultcore.azure.net}"]
      subnet_resource_id                    = var.remote_virtual_networks[each.key].subnets["primary-subnet1"].resource_id
      private_service_connection_name       = "psc-${var.naming.lz_custom_names[each.value.location_key].key_vault_name}-${each.value.index}"
      network_interface_name                = "nic-${var.naming.lz_custom_names[each.value.location_key].key_vault_name}-${each.value.index}"
    }
  }
  keys = {
    cmk_for_firewall_policy = {
        key_opts = ["decrypt", "encrypt", "sign", "verify", "wrapKey", "unwrapKey"]
        key_type = "RSA"
        key_size = 2048
        name = "cmk-for-firewall-policy"
    }
  }
  role_assignments = {
    deploy_user_kv_admin = {
      principal_id   = each.value.deploy_user_kv_admin_principal_id 
      role_definition_name = "Key Vault Administrator"
    }
    uami_fw_policy = {
      principal_id   = var.fwp_user_assigned_identity[each.key].principal_id //outputs
      role_definition_name = "Key Vault Secrets User"
    }
  }
  wait_for_rbac_before_key_operations = {
    create = "60s"
  }
  network_acls = {
    bypass = "AzureServices"
    ip_rules = each.value.runner_ip_ranges != [] ? each.value.runner_ip_ranges : null
  }
}
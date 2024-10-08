resource "azurerm_firewall_application_rule_collection" "azfw_app_rule" {
  name                = module.azfw_app_rule_name.naming_convention_output[var.naming_convention_info.name].names.0
  azure_firewall_name = var.azure_firewall_name
  resource_group_name = var.resource_group_name
  priority            = var.priority
  action              = var.action

  rule {
    name             = var.rule.name
    source_addresses = var.rule.source_addresses
    target_fqdns     = var.rule.target_fqdns
    protocol {
      port = var.rule.protocol.port
      type = var.rule.protocol.type
    }
  }
}
locals {
  naming_convention_info = {
    project_code = "project_code"
    env          = "env"
    zone         = "zone"
    tier         = "tier"
    name         = "name"
    agency_code  = "agency_code"
  }
  tags = {
    environment = "Production"
  }

}
module "resource_groups" {
  source = "git::https://github.com/BrettOJ/tf-az-module-resource-group?ref=main"
  resource_groups = {
    1 = {
      name                   = var.resource_group_name
      location               = var.location
      naming_convention_info = local.naming_convention_info
      tags = {
      }
    }
  }
}

module "azure_virtual_network" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-virtual-network?ref=main"
  location               = var.location
  resource_group_name    = module.resource_groups.rg_output[1].name
  address_space          = var.address_space
  dns_servers            = var.dns_servers
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags

}

module "azurerm_public_ip" {
  source                  = "git::https://github.com/BrettOJ/tf-az-module-network-public-ip"
  location                = var.location
  resource_group_name     = module.resource_groups.rg_output[1].name
  naming_convention_info  = local.naming_convention_info
  sku                     = var.sku
  allocation_method       = var.allocation_method
  domain_name_label       = var.domain_name_label
  ddos_protection_mode    = var.ddos_protection_mode
  ddos_protection_plan_id = var.ddos_protection_plan_id
  edge_zone               = var.edge_zone
  ip_tags                 = var.ip_tags
  ip_version              = var.ip_version
  idle_timeout_in_minutes = var.idle_timeout_in_minutes
  zones                   = var.zones
  tags                    = local.tags
}


module "azure_firewall_subnet" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-network-subnet?ref=main"
  resource_group_name    = module.resource_groups.rg_output[1].name
  virtual_network_name   = module.azure_virtual_network.vnets_output.name
  location               = var.location
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
  create_nsg             = var.create_nsg
  subnets = {
    AzureFirewallSubnet = {
      name                                      = "AzureFirewallSubnet"
      address_prefixes                          = ["10.0.1.0/26"]
      service_endpoints                         = null
      private_endpoint_network_policies_enabled = null
      route_table_id                            = null
      delegation                                = null
      nsg_inbound                               = []
      nsg_outbound                              = []
    }
  }
}

module "azure_firewall_management_subnet" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-network-subnet?ref=main"
  resource_group_name    = module.resource_groups.rg_output[1].name
  virtual_network_name   = module.azure_virtual_network.vnets_output.name
  location               = var.location
  naming_convention_info = local.naming_convention_info
  tags                   = local.tags
  create_nsg             = var.create_nsg
  subnets = {
    AzureFirewallManagementSubnet = {
      name                                      = "AzureFirewallManagementSubnet"
      address_prefixes                          = ["10.0.2.0/26"]
      service_endpoints                         = null
      private_endpoint_network_policies_enabled = null
      route_table_id                            = null
      delegation                                = null
      nsg_inbound                               = []
      nsg_outbound                              = []
    }
  }
}


module "azure_firewall" {
  source                 = "git::https://github.com/BrettOJ/tf-az-module-azure-firewall?ref=main"
  resource_group_name    = module.resource_groups.rg_output[1].name
  location               = var.location
  sku_name               = var.sku_name
  sku_tier               = var.sku_tier
  zones                  = var.zones
  tags                   = local.tags
  naming_convention_info = local.naming_convention_info
  threat_intel_mode      = var.threat_intel_mode
  private_ip_ranges      = var.private_ip_ranges
  dns_proxy_enabled      = var.dns_proxy_enabled
  dns_servers            = var.dns_servers
  firewall_policy_id     = var.firewall_policy_id


  ip_configuration = {
    name                 = var.ip_configuration_name
    subnet_id            = module.azure_firewall_subnet.snet_output.AzureFirewallSubnet.id
    public_ip_address_id = module.azurerm_public_ip.pip_output.id
  }
  /*
  # force split tunnel management - requires an additional PIP
  management_ip_configuration = {
    name                 = var.management_ip_configuration_name
    subnet_id            = module.azure_firewall_management_subnet.snet_output.AzureFirewallManagementSubnet.id
    public_ip_address_id = module.azurerm_public_ip.pip_output.id
  }
*/
}


module "azurerm_firewall_application_rule_collection" {
  source              = "../"
  azure_firewall_name = module.azure_firewall.azfw_output.name
  resource_group_name = var.resource_group_name
  priority            = var.priority
  action              = var.action
  tags                = local.tags
  naming_convention_info = local.naming_convention_info
  rule = {
    name             = var.rule_name
    source_addresses = var.rule_source_addresses
    target_fqdns     = var.rule_target_fqdns
    protocol = {
      port = var.rule_protocol_port
      type = var.rule_protocol_type
    }
  }
}




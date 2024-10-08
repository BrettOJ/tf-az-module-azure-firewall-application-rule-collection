
variable "address_space" {
  type = list(string)
}

variable "location" {
  type    = string
  default = "southeastasia"
}

variable "resource_group_name" {
  type    = string
  default = "vnet-rg"
}

variable "bgp_community" {
  type    = string
  default = null
}

variable "ddos_protection_plan" {
  type = map(any)
  default = {
    id     = ""
    enable = false
  }
}

variable "encryption" {
  type = map(any)
  default = {
    enforcement = ""
  }
}

variable "dns_servers" {
  type    = list(string)
  default = ["168.63.129.16"]
}

variable "edge_zone" {
  type    = string
  default = ""
}

variable "flow_timeout_in_minutes" {
  type    = number
  default = 4
}

variable "tags" {
  type = map(any)
  default = {
    environment = "dev"
  }
}

variable "create_nsg" {
  type    = bool
  default = false

}

variable "source_addresses" {
  type    = list(string)
  default = []

}

variable "target_fqdns" {
  type    = list(string)
  default = []
}

variable "port" {
  type    = string
  default = ""
}

variable "type" {
  type    = string
  default = ""
}


variable "allocation_method" {
  type        = string
  default     = "Dynamic"
  description = "Allocation method of IP."
}

variable "domain_name_label" {
  type        = string
  default     = null
  description = "Domain name lable"
}

variable "zones" {
  type        = list(string)
  default     = null
  description = "Domain name lable"
}

variable "sku" {
  description = "The SKU of public ip - Basic/Standard"
  type        = string
  default     = "Basic"
}

variable "reverse_fqdn" {
  description = "Reverse FQD"
  type        = string
  default     = null
}

variable "ddos_protection_mode" {
  description = "The DDoS protection mode of the public IP. Possible values are Disabled, Enabled, and VirtualNetworkInherited. Defaults to VirtualNetworkInherited."
  type        = string
  default     = "VirtualNetworkInherited"
}

variable "ddos_protection_plan_id" {
  description = "The ID of DDoS protection plan associated with the public IP."
  type        = string
  default     = null
}

variable "idle_timeout_in_minutes" {
  description = "Specifies the timeout for the TCP idle connection. The value can be set between 4 and 30 minutes."
  type        = number
  default     = 4
}

variable "ip_tags" {
  description = "A mapping of IP tags to assign to the public IP. Changing this forces a new resource to be created."
  type        = map(string)
  default     = {}
}

variable "ip_version" {
  description = "The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created."
  type        = string
  default     = "IPv4"
}

variable "public_ip_prefix_id" {
  description = "If specified then public IP address allocated will be provided from the public IP prefix resource. Changing this forces a new resource to be created"
  type        = string
  default     = null
}

variable "management_ip_configuration_name" {
  description = "The name of the IP configuration to use for management traffic. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "public_ip_address_id" {
  description = "The ID of the public IP address. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "ip_configuration_name" {
  description = "The name of the IP configuration to use for the firewall traffic. Changing this forces a new resource to be created."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The name of the SKU of the Azure Firewall. Possible values are AZFW_VNet, AZFW_Hub, and AZFW_HubPremium. Defaults to AZFW_VNet."
  type        = string
  default     = "AZFW_VNet"

}

variable "sku_tier" {
  description = "The tier of the SKU of the Azure Firewall. Possible values are Standard and Premium. Defaults to Standard."
  type        = string
  default     = "Standard"
}

variable "threat_intel_mode" {
  description = "The mode of threat intelligence to be enabled on the Azure Firewall. Possible values are Alert and Deny. Defaults to Alert."
  type        = string
  default     = "Alert"

}

variable "private_ip_ranges" {
  description = "The private IP ranges of the Azure Firewall."
  type        = list(string)
  default     = []
}

variable "dns_proxy_enabled" {
  description = "Is DNS Proxy enabled on the Azure Firewall. Defaults to false."
  type        = bool
  default     = false
}

variable "firewall_policy_id" {
  description = "The ID of the Firewall Policy to associate with the Azure Firewall."
  type        = string
  default     = null
}


variable "priority" {
  description = "The priority of the rule collection."
}

variable "action" {
  description = "The action the rule will apply to matching traffic."
}

variable "rule_name" {
  description = "The name of the rule."
}

variable "rule_source_addresses" {
  description = "The source addresses of the rule."
  type        = list(string)
  default     = []
}

variable "rule_target_fqdns" {
  description = "The target FQDNs of the rule."
  type        = list(string)
  default     = []
}


variable "rule_protocol_port" {
  description = "The port of the protocol."
  type        = number
  default     = 0
}

variable "rule_protocol_type" {
  description = "The type of the protocol."
  type        = string
  default     = ""
}

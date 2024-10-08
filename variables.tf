#variable file for the Azure firewall application rule module

variable "azure_firewall_name" {
  description = "The name of the Azure Firewall."
}

variable "resource_group_name" {
  description = "The name of the resource group in which the Azure Firewall exists."
}

variable "priority" {
  description = "The priority of the rule collection."
}

variable "action" {
  description = "The action the rule will apply to matching traffic."
}

variable "rule" {
  description = "The rule to apply to the Azure Firewall."
  type        = object({
    name             = string
    source_addresses = list(string)
    target_fqdns     = list(string)
    protocol = object({
      port = number
      type = string
    })
  })
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}

variable "naming_convention_info" {
  description = "A naming_convention_info block as defined below."
  type = object({
    name         = string
    project_code = string
    env          = string
    zone         = string
    agency_code  = string
    tier         = string
  })
  
}

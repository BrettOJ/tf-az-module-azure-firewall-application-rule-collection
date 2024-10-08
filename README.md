Manages an Application Rule Collection within an Azure Firewall.

## [Example Usage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#example-usage)

```hcl
resource "azurerm_resource_group" "example" { name = "example-resources" location = "West Europe" } resource "azurerm_virtual_network" "example" { name = "testvnet" address_space = ["10.0.0.0/16"] location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name } resource "azurerm_subnet" "example" { name = "AzureFirewallSubnet" resource_group_name = azurerm_resource_group.example.name virtual_network_name = azurerm_virtual_network.example.name address_prefixes = ["10.0.1.0/24"] } resource "azurerm_public_ip" "example" { name = "testpip" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name allocation_method = "Static" sku = "Standard" } resource "azurerm_firewall" "example" { name = "testfirewall" location = azurerm_resource_group.example.location resource_group_name = azurerm_resource_group.example.name sku_name = "AZFW_VNet" sku_tier = "Standard" ip_configuration { name = "configuration" subnet_id = azurerm_subnet.example.id public_ip_address_id = azurerm_public_ip.example.id } } resource "azurerm_firewall_application_rule_collection" "example" { name = "testcollection" azure_firewall_name = azurerm_firewall.example.name resource_group_name = azurerm_resource_group.example.name priority = 100 action = "Allow" rule { name = "testrule" source_addresses = [ "10.0.0.0/16", ] target_fqdns = [ "*.google.com", ] protocol { port = "443" type = "Https" } } }
```

## [Argument Reference](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#argument-reference)

The following arguments are supported:

-   [`name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#name) - (Required) Specifies the name of the Application Rule Collection which must be unique within the Firewall. Changing this forces a new resource to be created.
    
-   [`azure_firewall_name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#azure_firewall_name) - (Required) Specifies the name of the Firewall in which the Application Rule Collection should be created. Changing this forces a new resource to be created.
    
-   [`resource_group_name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#resource_group_name) - (Required) Specifies the name of the Resource Group in which the Firewall exists. Changing this forces a new resource to be created.
    
-   [`priority`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#priority) - (Required) Specifies the priority of the rule collection. Possible values are between `100` - `65000`.
    
-   [`action`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#action) - (Required) Specifies the action the rule will apply to matching traffic. Possible values are `Allow` and `Deny`.
    
-   [`rule`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#rule) - (Required) One or more `rule` blocks as defined below.
    

___

A `rule` block supports the following:

-   [`name`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#name) - (Required) Specifies the name of the rule.
    
-   [`description`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#description) - (Optional) Specifies a description for the rule.
    
-   [`source_addresses`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#source_addresses) - (Optional) A list of source IP addresses and/or IP ranges.
    
-   [`source_ip_groups`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#source_ip_groups) - (Optional) A list of source IP Group IDs for the rule.
    

-   [`fqdn_tags`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#fqdn_tags) - (Optional) A list of FQDN tags. Possible values are `AppServiceEnvironment`, `AzureBackup`, `AzureKubernetesService`, `HDInsight`, `MicrosoftActiveProtectionService`, `WindowsDiagnostics`, `WindowsUpdate` and `WindowsVirtualDesktop`.
    
-   [`target_fqdns`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#target_fqdns) - (Optional) A list of FQDNs.
    
-   [`protocol`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#protocol) - (Optional) One or more `protocol` blocks as defined below.
    

___

A `protocol` block supports the following:

-   [`port`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#port) - (Required) Specify a port for the connection.
    
-   [`type`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#type) - (Required) Specifies the type of connection. Possible values are `Http`, `Https` and `Mssql`.
    

## [Timeouts](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#timeouts)

The `timeouts` block allows you to specify [timeouts](https://www.terraform.io/language/resources/syntax#operation-timeouts) for certain actions:

-   [`create`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#create) - (Defaults to 30 minutes) Used when creating the Firewall Application Rule Collection.
-   [`update`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#update) - (Defaults to 30 minutes) Used when updating the Firewall Application Rule Collection.
-   [`read`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#read) - (Defaults to 5 minutes) Used when retrieving the Firewall Application Rule Collection.
-   [`delete`](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#delete) - (Defaults to 30 minutes) Used when deleting the Firewall Application Rule Collection.

## [Import](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine#import)

Firewall Application Rule Collections can be imported using the `resource id`, e.g.

```shell
terraform import azurerm_firewall_application_rule_collection.example /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/mygroup1/providers/Microsoft.Network/azureFirewalls/myfirewall/applicationRuleCollections/mycollection
```
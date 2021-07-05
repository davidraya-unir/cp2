
# Creación de subnet
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet

resource "azurerm_subnet" "mySubnet" {
	count				   = length(var.vms)
    name                   = "subnet-${var.vms[count.index].name}"
    resource_group_name    = azurerm_resource_group.rg.name
    virtual_network_name   = azurerm_virtual_network.myNet.name
    address_prefixes       = ["10.0.${100 + count.index}.0/24"]

}

# Create NIC
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_interface

resource "azurerm_network_interface" "myNic1" {
	count				= length(var.vms)
	name                = "vmnic-${var.vms[count.index].name}"  
	location            = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name

    ip_configuration {
		name                           = "myipconfiguration1"
		subnet_id                      = azurerm_subnet.mySubnet[count.index].id
		private_ip_address_allocation  = "Static"
		private_ip_address             = "10.0.${100 + count.index}.10"
		public_ip_address_id           = azurerm_public_ip.myPublicIp1[count.index].id
	}	

    tags = {
        environment = "CP2"
    }

}

# IP pública
# https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/public_ip

resource "azurerm_public_ip" "myPublicIp1" {
	count				= length(var.vms)
	name                = "vmip-${var.vms[count.index].name}"
	location            = azurerm_resource_group.rg.location
	resource_group_name = azurerm_resource_group.rg.name
	allocation_method   = "Dynamic"
	sku                 = "Basic"

    tags = {
        environment = "CP2"
    }

}
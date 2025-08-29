resource "azurerm_virtual_network" "vnet" {
  name                = "MinecraftServerVirtualNetwork"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "subnet" {
  name                 = "MinecraftServerSubnet"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pubip" {
  name                    = "MinecraftServerPublicIP"
  location                = azurerm_resource_group.rg.location
  resource_group_name     = azurerm_resource_group.rg.name
  allocation_method       = "Static"
  idle_timeout_in_minutes = 30
  sku                     = "Standard"
}

resource "azurerm_network_interface" "netint" {
  name                = "MinecraftServerNetworkInterface"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "testconfiguration1"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = "10.0.2.5"
    public_ip_address_id          = azurerm_public_ip.pubip.id
  }
}

data "azurerm_public_ip" "pubip" {
  name                = azurerm_public_ip.pubip.name
  resource_group_name = azurerm_linux_virtual_machine.vm.resource_group_name
}

output "public_ip_address" {
  value = data.azurerm_public_ip.pubip.ip_address
}

resource "azurerm_network_security_group" "netsec" {
  name                = "MinecraftServerNetworkSecurityGroup"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Java"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "25565"
    source_address_prefix      = "*"
    destination_address_prefix = "0.0.0.0/0"
  }
}

resource "azurerm_network_interface_security_group_association" "groupassociation" {
  network_interface_id      = azurerm_network_interface.netint.id
  network_security_group_id = azurerm_network_security_group.netsec.id
}
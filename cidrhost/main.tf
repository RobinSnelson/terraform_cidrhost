provider "azurerm" {
  features {}
}

#create the resource group to contain all the resources
resource "azurerm_resource_group" "main_rg" {
  name     = "${var.project_name}-rg"
  location = var.default_location

}

#create the main virtual network for the environment
resource "azurerm_virtual_network" "main_vnet" {
  name                = "${var.project_name}-vnet"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = var.default_location

  address_space = [
    "${var.main_vnet_address_space}"
  ]

}
#create a main subnet to contain the interface for the code testing network
resource "azurerm_subnet" "main_subnet" {
  name                 = "${var.project_name}-subnet"
  resource_group_name  = azurerm_resource_group.main_rg.name
  virtual_network_name = azurerm_virtual_network.main_vnet.name

  address_prefixes = [
    "${var.subnet_address_prefix}"
  ]
}

#Network Interfaces for the test
resource "azurerm_network_interface" "interface" {
  name                = "${var.project_name}-${count.index}-int"
  resource_group_name = azurerm_resource_group.main_rg.name
  location            = var.default_location
  count               = var.int_count

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.main_subnet.id
    private_ip_address_allocation = "Static"
    private_ip_address            = cidrhost(var.subnet_address_prefix, count.index + 10)

  }

}

locals {
  resource_tags = {
    environment = "Production"
  }
}
resource "azurerm_resource_group" "example" {
  name     = var.resource_group_details[0]
  location = var.resource_group_details[1]
  tags = local.resource_tags
}


resource "azurerm_virtual_network" "example" {
  name                = var.vnet_details.name
  address_space       = [var.vnet_details.address_space]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  tags = local.resource_tags
}

resource "azurerm_subnet" "example" {
  name                 = "sai-internal"
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_network_interface" "example" {
  name                = "sai-example-nic"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.example.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example.id
  }
  tags = local.resource_tags
}


resource "azurerm_public_ip" "example" {
  name                = var.public_ip
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  allocation_method   = "Static"

  tags = local.resource_tags
}


# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}


resource "azurerm_resource_group" "terraform-rg" {
  name     = "terraform-rg"
  location = "East Us"
  tags = {
    environment = "dev"
  }
}


resource "azurerm_virtual_network" "terraform-net" {
  name                = "terraform-net"
  resource_group_name = azurerm_resource_group.terraform-rg.name
  location            = azurerm_resource_group.terraform-rg.location
  address_space       = ["1.123.0.0/16"]

  tags = {
    environment = "dev"
  }
}



resource "azurerm_subnet" "terraform-subnet" {
  name                 = "terraform-sub"
  resource_group_name  = azurerm_resource_group.terraform-rg.name
  virtual_network_name = azurerm_virtual_network.terraform-net.name
  address_prefixes     = ["1.123.1.0/24"]
}

resource "azurerm_network_security_group" "terraform-sg" {
  name                = "terraform-sg"
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name

  tags = {
    environment = "dev"
  }
}


resource "azurerm_network_security_rule" "terraform-dev-rule" {
  name                        = "terraform-dev-rule"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "72.212.165.38/32"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.terraform-rg.name
  network_security_group_name = azurerm_network_security_group.terraform-sg.name
}


resource "azurerm_public_ip" "terraform-ip" {
  name                = "terraform-ip"
  resource_group_name = azurerm_resource_group.terraform-rg.name
  location            = azurerm_resource_group.terraform-rg.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Dev"
  }
}



resource "azurerm_network_interface" "terraform-nic" {
  name                = "terraform-nic"
  location            = azurerm_resource_group.terraform-rg.location
  resource_group_name = azurerm_resource_group.terraform-rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.terraform-subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.terraform-ip.id
  }

  tags = {
    envrionment = "dev"
  }
}


resource "azurerm_linux_virtual_machine" "terraform-vm" {
  name                  = "terraform-vm"
  resource_group_name   = azurerm_resource_group.terraform-rg.name
  location              = azurerm_resource_group.terraform-rg.location
  size                  = "Standard_B1s"
  admin_username        = "adminuser"
  network_interface_ids = [azurerm_network_interface.terraform-nic.id]


  custom_data = filebase64("customdata.tpl")

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("~/.ssh/terraformazurekey.pub")
  }


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }


  tags = {
    environment = "dev"
  }
}



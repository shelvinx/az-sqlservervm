# locals.tf

# NSG Rules
locals {
  nsg_rules = {
    "allowrdp" = {
      name                       = "AllowRDP"
      access                     = "Allow"
      destination_address_prefix = "*"
      destination_port_range     = "3389"
      direction                  = "Inbound"
      priority                   = 1000
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
    "allowicmp" = {
      name                       = "AllowICMP"
      access                     = "Allow"
      destination_address_prefix = "*"
      destination_port_range     = "*"
      direction                  = "Inbound"
      priority                   = 1001
      protocol                   = "Icmp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
    "allowwinrm" = {
      name                       = "AllowWinRM"
      access                     = "Allow"
      destination_address_prefix = "*"
      destination_port_range     = "5985-5986"
      direction                  = "Inbound"
      priority                   = 1002
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
    "allowssh" = {
      name                       = "AllowSSH"
      access                     = "Allow"
      destination_address_prefix = "*"
      destination_port_range     = "22"
      direction                  = "Inbound"
      priority                   = 1003
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
    "allowhttp" = {
      name                       = "AllowHTTP"
      access                     = "Allow"
      destination_address_prefix = "*"
      destination_port_range     = "80"
      direction                  = "Inbound"
      priority                   = 1004
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
    "allowhttps" = {
      name                       = "AllowHTTPS"
      access                     = "Allow"
      destination_address_prefix = "*"
      destination_port_range     = "443"
      direction                  = "Inbound"
      priority                   = 1005
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
    "allowsql" = {
      name                       = "AllowSQL"
      access                     = "Allow"
      destination_address_prefix = "*"
      destination_port_range     = "1433"
      direction                  = "Inbound"
      priority                   = 1006
      protocol                   = "Tcp"
      source_address_prefix      = "*"
      source_port_range          = "*"
    }
  }
}
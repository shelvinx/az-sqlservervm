# az.sqlservervm.tf
# Naming Module
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.4.2"
  suffix  = [var.workload_suffix]
}

# Resource Group
module "resource_group" {
  source   = "Azure/avm-res-resources-resourcegroup/azurerm"
  version  = "0.2.1"
  name     = module.naming.resource_group.name
  location = var.location
  tags     = var.tags
}

# Accept Marketplace terms
resource "azurerm_marketplace_agreement" "sql" {
  publisher = "MicrosoftSQLServer"
  offer     = "sql2022-ws2022"
  plan      = "sqldev-gen2"
}

# AVM Virtual Machine
module "windows_vm" {
  source                     = "Azure/avm-res-compute-virtualmachine/azurerm"
  version                    = "0.19.0"
  location                   = var.location
  resource_group_name        = module.resource_group.name
  name                       = module.naming.virtual_machine.name
  os_type                    = "Windows"
  sku_size                   = var.vm_sku_size
  zone                       = null
  encryption_at_host_enabled = false

  # Ensure marketplace agreement is accepted first
  depends_on = [azurerm_marketplace_agreement.sql]

  account_credentials = {
    admin_credentials = {
      username                           = "azureuser"
      password                           = var.admin_password
      generate_admin_password_or_ssh_key = false
    }
  }

  os_disk = {
    name                 = "${module.naming.virtual_machine.name}-osdisk" # More descriptive name
    caching              = "ReadWrite"
    storage_account_type = "StandardSSD_LRS"
  }

  source_image_reference = {
    publisher = "MicrosoftSQLServer"
    offer     = "sql2022-ws2022"
    sku       = "sqldev-gen2"
    version   = "latest"
  }

  network_interfaces = {
    network_interface_1 = {
      name = module.naming.network_interface.name
      ip_configurations = {
        ip_configurations_1 = {
          name                          = "ipconfig"
          private_ip_subnet_resource_id = module.vnet_test.subnets.vm_subnet_1.resource_id
          public_ip_address_resource_id = module.pip_windows.resource_id
        }
      }
    }
  }

  # Spot VM configuration
  priority        = "Spot"
  max_bid_price   = "0.08"
  eviction_policy = "Deallocate"

  extensions = {
    script = {
      name                       = "ConfigurationScript"
      publisher                  = "Microsoft.Compute"
      type                       = "CustomScriptExtension"
      type_handler_version       = "1.10"
      auto_upgrade_minor_version = true
      settings                   = <<SETTINGS
      {
        "fileUris": [
          "https://raw.githubusercontent.com/shelvinx/terraform-az-infra/refs/heads/main/scripts/vm-config.ps1"
        ],
        "commandToExecute": "powershell -ExecutionPolicy Unrestricted -File vm-config.ps1"
      }
      SETTINGS
    }
  }

  tags = var.tags
}
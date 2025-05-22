# terraform.tfvars

location            = "uksouth"
resource_group_name = "rg-sqlservervm"

workload_suffix = "sqlservervm"
tags = {
  environment = "dev"
  project     = "sqlservervm"
}

vm_sku_size = "Standard_D4als_v6"
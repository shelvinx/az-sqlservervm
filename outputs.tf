# outputs.tf
# FQDN
output "fqdn" {
  value = "${module.naming.virtual_machine.name}.${var.location}.cloudapp.azure.com"
}
output "bastion_ip" {
  value = azurerm_public_ip.bastion.ip_address
}


output "db_ip" {
   value = [azurerm_network_interface.db.*.private_ip_address]
}

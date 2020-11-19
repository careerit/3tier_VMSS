output "bastion_ip" {
  value = azurerm_public_ip.bastion.ip_address
}


output "db_ip" {
   value = [azurerm_network_interface.db.*.private_ip_address]
}


output "win_ip" {
   value = [azurerm_network_interface.win.*.private_ip_address]
}

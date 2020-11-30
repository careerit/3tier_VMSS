output "ansible_ip" {
  value = azurerm_public_ip.ansible.ip_address
}

output "web_ip" {
   value = [azurerm_network_interface.web.*.private_ip_address]
}



output "db_ip" {
   value = [azurerm_network_interface.db.*.private_ip_address]
}


output "win_ip" {
   value = [azurerm_network_interface.win.*.private_ip_address]
}

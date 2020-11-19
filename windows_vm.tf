resource "azurerm_windows_virtual_machine" "win" {
  count = var.win_node_count  
  name                = "win-${count.index}"
  resource_group_name = azurerm_resource_group.myapp.name
  location            = azurerm_resource_group.myapp.location
  size                = "Standard_F2"
  admin_username      = var.username
  admin_password      = var.password
  network_interface_ids = [element(azurerm_network_interface.win.*.id, count.index)]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }
}
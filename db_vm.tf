#Build db nodes

#Fetch the Cloudinit (userdate) file

data "template_file" "db" {
  template = file("${path.module}/Templates/cloudnint-db.tpl")
}

resource "azurerm_virtual_machine" "db" {
  count                 = var.db_node_count
  name                  = "${var.prefix}-db-${count.index}"
  location              = azurerm_resource_group.myapp.location
  resource_group_name   = azurerm_resource_group.myapp.name
  network_interface_ids = [element(azurerm_network_interface.db.*.id, count.index)]
  vm_size               = var.db_vm_size
  depends_on            = [azurerm_virtual_machine.bastion]
  # This means the OS Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_os_disk_on_termination = true

  # This means the Data Disk Disk will be deleted when Terraform destroys the Virtual Machine
  # NOTE: This may not be optimal in all cases.
  delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-db-${count.index}-db-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-db-${count.index}"
    admin_username = var.username
    custom_data    = data.template_file.db.rendered
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = data.template_file.key_data.rendered
      path     = var.destination_ssh_key_path
    }
  }


}


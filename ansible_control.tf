#Fetch the Cloudinit (userdate) file

data "template_file" "ansible" {
  template = file("${path.module}/Templates/cloudnint-ansible.tpl")
}

data "template_file" "key_data" {
  template = file("/opt/lab/keys/id_ansible.pub")
}

resource "azurerm_virtual_machine" "ansible" {
  name                  = "${var.prefix}-ansible"
  location              = azurerm_resource_group.myapp.location
  resource_group_name   = azurerm_resource_group.myapp.name
  network_interface_ids = [azurerm_network_interface.ansible.id]
  vm_size               = var.ansible_vm_size

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
    name              = "${var.prefix}-ansible-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-ansible"
    admin_username = var.username
    custom_data    = data.template_file.ansible.rendered
    
  }

  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = data.template_file.key_data.rendered
      path     = var.destination_ssh_key_path
    }
  }
}

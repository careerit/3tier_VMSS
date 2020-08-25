data "template_file" "web" {
  template = file("${path.module}/Templates/cloudnint-web.tpl")
}


resource "azurerm_linux_virtual_machine_scale_set" "web" {
  name                = "myapp-vmss"
  resource_group_name = azurerm_resource_group.myapp.name
  location            = azurerm_resource_group.myapp.location
  sku                 = var.web_vm_size
  instances           = var.web_default_vms
  admin_username      = var.username
  custom_data         = base64encode(data.template_file.web.rendered)

  admin_ssh_key {
    username   = var.username
    public_key = file("/opt/class/keys/id_az_rsa.pub")
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  network_interface {
    name    = "myapp"
    primary = true

    ip_configuration {
      name      = "web"
      primary   = true
      subnet_id = azurerm_subnet.web.id
      load_balancer_backend_address_pool_ids = [azurerm_lb_backend_address_pool.webpool.id]
    }
    
  }

  # Since these can change via auto-scaling outside of Terraform,
  # let's ignore any changes to the number of instances
  lifecycle {
    ignore_changes = [instances]
  }
   
}


resource "azurerm_monitor_autoscale_setting" "myapp" {
  name                = "autoscale-config"
  resource_group_name = azurerm_resource_group.myapp.name
  location            = azurerm_resource_group.myapp.location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.web.id

  profile {
    name = "AutoScale"

    capacity {
      default = var.web_default_vms
      minimum = var.web_minimum_vms
      maximum = var.web_maximum_vms
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.web.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}

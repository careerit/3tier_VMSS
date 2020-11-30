# Security Group for ansible Node

resource "azurerm_network_security_group" "ansible" {
  name                = "ansible"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name
}

resource "azurerm_network_security_rule" "ansible" {
  count                       = length(var.ansible_inbound_ports)
  name                        = "sgrule-ansible-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.ansible_inbound_ports, count.index)
  protocol                    = "TCP"
  resource_group_name         = azurerm_resource_group.myapp.name
  network_security_group_name = azurerm_network_security_group.ansible.name
}


# Associate ansible NSG To ansible subnet
resource "azurerm_subnet_network_security_group_association" "ansible" {
  subnet_id = azurerm_subnet.ansible.id
  network_security_group_id = azurerm_network_security_group.ansible.id
}


# Security Group for Windows 

resource "azurerm_network_security_group" "win" {
  name                = "win"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name
}


# Security Group rules for Windows

resource "azurerm_network_security_rule" "win" {
  count                       = length(var.win_inbound_ports)
  name                        = "sgrule-win-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.win_inbound_ports, count.index)
  protocol                    = "TCP"
  resource_group_name         = azurerm_resource_group.myapp.name
  network_security_group_name = azurerm_network_security_group.win.name
}


# Windows Security Group Association

resource "azurerm_subnet_network_security_group_association" "win" {
  subnet_id = azurerm_subnet.win.id
  network_security_group_id = azurerm_network_security_group.win.id
}


# Security Group for db  Node
resource "azurerm_network_security_group" "db" {
  name                = "db"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name
}

resource "azurerm_network_security_rule" "db" {
  count                       = length(var.db_inbound_ports)
  name                        = "sgrule-db-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.db_inbound_ports, count.index)
  protocol                    = "TCP"
  resource_group_name         = azurerm_resource_group.myapp.name
  network_security_group_name = azurerm_network_security_group.db.name
}


# DB Security Group Association

resource "azurerm_subnet_network_security_group_association" "db" {
  subnet_id = azurerm_subnet.db.id
  network_security_group_id = azurerm_network_security_group.db.id
}



# Security Group for web  Node
resource "azurerm_network_security_group" "web" {
  name                = "web"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name
}

resource "azurerm_network_security_rule" "web" {
  count                       = length(var.web_inbound_ports)
  name                        = "sgrule-web-${count.index}"
  direction                   = "Inbound"
  access                      = "Allow"
  priority                    = 100 * (count.index + 1)
  source_address_prefix       = "*"
  source_port_range           = "*"
  destination_address_prefix  = "*"
  destination_port_range      = element(var.web_inbound_ports, count.index)
  protocol                    = "TCP"
  resource_group_name         = azurerm_resource_group.myapp.name
  network_security_group_name = azurerm_network_security_group.web.name
}


# web Security Group Association

resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id = azurerm_subnet.web.id
  network_security_group_id = azurerm_network_security_group.web.id
}

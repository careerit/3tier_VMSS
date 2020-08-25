
resource "azurerm_virtual_network" "myapp" {
  name                = "${var.prefix}-network"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name
  tags                = var.tags
}

resource "azurerm_subnet" "bastion" {
  name                 = "bastion"
  resource_group_name  = azurerm_resource_group.myapp.name
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes       = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "web" {
  name                 = "web"
  resource_group_name  = azurerm_resource_group.myapp.name
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes       = ["10.0.1.0/24"]
}




resource "azurerm_subnet" "db" {
  name                 = "db"
  resource_group_name  = azurerm_resource_group.myapp.name
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes       = ["10.0.3.0/24"]
}

# NIC and IPs for bastion Node
resource "azurerm_public_ip" "bastion" {
  name                = "${var.prefix}-bastion-pip"
  resource_group_name = azurerm_resource_group.myapp.name
  location            = azurerm_resource_group.myapp.location
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags
}


resource "azurerm_network_interface" "bastion" {
  name                = "${var.prefix}-nic-bastion"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  ip_configuration {
    name                          = "configuration"
    subnet_id                     = azurerm_subnet.bastion.id
    private_ip_address_allocation = "dynamic"
    public_ip_address_id          = azurerm_public_ip.bastion.id
  }
}

# NIC and IPs for db Nodes

// resource "azurerm_public_ip" "db" {
//   count               = "${var.db_node_count}"
//   name                = "${var.prefix}-${count.index}-db-pip"
//   resource_group_name = "${azurerm_resource_group.myapp.name}"
//   location            = "${azurerm_resource_group.myapp.location}"
//   allocation_method   = "Dynamic"
//   sku                 = "Basic"
//   tags                = "${var.tags}"
// }

resource "azurerm_network_interface" "db" {
  count               = var.db_node_count
  name                = "${var.prefix}-nic-db-${count.index}"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  ip_configuration {
    name                          = "configuration-${count.index}"
    subnet_id                     = azurerm_subnet.db.id
    private_ip_address_allocation = "Dynamic"
  }
}

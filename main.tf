provider "azurerm" {
  version         = "~>2.30.0"
    features {
  }
}


resource "azurerm_resource_group" "myapp" {
  name     = "${var.prefix}-RG"
  location = var.location
  tags     = var.tags
}

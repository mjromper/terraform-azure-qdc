resource "azurerm_virtual_network" "qdc-virtual-network" {
  name                = "${var.deloyment_name}-vn"
  address_space       = ["10.0.0.0/16"]
  location            = "${azurerm_resource_group.qdc.location}"
  resource_group_name = "${azurerm_resource_group.qdc.name}"
}

resource "azurerm_subnet" "qdc-subnet" {
  name                      = "${var.deloyment_name}-subnet"
  resource_group_name       = "${azurerm_resource_group.qdc.name}"
  virtual_network_name      = "${azurerm_virtual_network.qdc-virtual-network.name}"
  address_prefix            = "10.0.2.0/24"
  network_security_group_id = "${azurerm_network_security_group.qdc-nsg.id}"
}


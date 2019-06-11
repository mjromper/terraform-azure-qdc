# No Network is setup. 
# It will use predifined Pre-Sales-subnet 

#resource "azurerm_virtual_network" "qdc-virtual-network" {
#  name                = "${var.deloyment_name}-vn"
#  address_space       = ["10.0.0.0/16"]
#  location            = "US East"
#  resource_group_name = "Pre-Sales-aor"
#}

#resource "azurerm_subnet" "qdc-subnet" {
#  name                      = "Pre-Sales-subnet"
#  resource_group_name       = "Pre-Sales-aor"
#  virtual_network_name      = "${azurerm_virtual_network.qdc-virtual-network.name}"
#  address_prefix            = "10.0.2.0/24"
#  network_security_group_id = "${azurerm_network_security_group.qdc-nsg.id}"
#}
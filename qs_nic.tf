# Comment: No public IP is created.

#resource "azurerm_public_ip" "qdc-pub-ip" {
#  location                     = "${azurerm_resource_group.qdc.location}"
#  resource_group_name          = "${azurerm_resource_group.qdc.name}"
#  #public_ip_address_allocation = "Dynamic"
#  allocation_method             = "Dynamic"
#  domain_name_label             = "${var.server_hostname}"
#  idle_timeout_in_minutes      = 30
#
#  tags = {
#    environment = "Terraform QDC Demo"
#  }
#}

resource "azurerm_network_interface" "qdc-nic" {
  name                = "qdc-nic"
  location            = "${var.azure_location}"
  resource_group_name = "${var.presales_rg_name}" 
  
  network_security_group_id = "${azurerm_network_security_group.qdc-nsg.id}"

  ip_configuration {
    name                          = "qdc-ip-cfg"
    #subnet_id                     = "${azurerm_subnet.qdc-subnet.id}"
    subnet_id                     = "${var.presales_subnet_id}"
    private_ip_address_allocation = "Dynamic"
    #public_ip_address_id          = "${azurerm_public_ip.qdc-pub-ip.id}"
  }
    tags = {
      environment = "Terraform QDC Demo"
    }
}


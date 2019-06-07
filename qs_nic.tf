resource "azurerm_public_ip" "qdc-pub-ip" {
  name                         = "qdc-pub-ip"
  location                     = "${azurerm_resource_group.qdc.location}"
  resource_group_name          = "${azurerm_resource_group.qdc.name}"
  #public_ip_address_allocation = "Dynamic"
  allocation_method             = "Dynamic"
  domain_name_label             = "${var.server_hostname}"
  idle_timeout_in_minutes      = 30

  tags = {
    environment = "Terraform QDC Demo"
  }
}

resource "azurerm_network_interface" "qdc-nic" {
  name                = "qdc-nic"
  location            = "${azurerm_resource_group.qdc.location}"
  resource_group_name = "${azurerm_resource_group.qdc.name}"
  network_security_group_id = "${azurerm_network_security_group.qdc-nsg.id}"

  ip_configuration {
    name                          = "qdc-ip-cfg"
    subnet_id                     = "${azurerm_subnet.qdc-subnet.id}"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = "${azurerm_public_ip.qdc-pub-ip.id}"
  }
    tags = {
      environment = "Terraform QDC Demo"
    }
}


resource "azurerm_network_security_group" "qdc-nsg" {
  name                = "${var.deloyment_name}_nsg"
  #location            = "${azurerm_resource_group.qdc.location}"
  #resource_group_name = "${azurerm_resource_group.qdc.name}"
  location            = "${var.azure_location}"
  resource_group_name = "${var.presales_rg_name}" 

      tags = {
        environment = "Terraform QDC Demo"
    }
}

resource "azurerm_network_security_rule" "http" {
  name                        = "http"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "8080"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  #resource_group_name         = "${azurerm_resource_group.qdc.name}"
  resource_group_name = "${var.presales_rg_name}"
  network_security_group_name = "${azurerm_network_security_group.qdc-nsg.name}"
}


resource "azurerm_network_security_rule" "ssh" {
  name                       = "SSH"
  priority                   = 1001
  direction                  = "Inbound"
  access                     = "Allow"
  protocol                   = "Tcp"
  source_port_range          = "*"
  destination_port_range     = "22"
  source_address_prefix      = "*"
  destination_address_prefix = "*"
  #resource_group_name         = "${azurerm_resource_group.qdc.name}"
  resource_group_name = "${var.presales_rg_name}"
  network_security_group_name = "${azurerm_network_security_group.qdc-nsg.name}"
}
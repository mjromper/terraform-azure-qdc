# Configure the Microsoft Azure Provider
provider "azurerm" {
  subscription_id = "${var.subscription_id}"
  #client_id       = "${var.client_id}"
  #client_secret   = "${var.client_secret}"
  #tenant_id       = "${var.tenant_id}"
}


# No need to create a resource group as all should go into
# your predifined assigned Pre-Sales-TRIGRAM resource group.
#
#resource "azurerm_resource_group" "qdc" {
#  name     = "${var.qdc_rg}"
#  location = "${var.azure_location}"
#}


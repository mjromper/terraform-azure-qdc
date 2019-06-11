resource "random_id" "randomId" {
    keepers = {
        # Generate a new ID only when a new resource group is defined
        #resource_group = "${azurerm_resource_group.qdc.name}"
        resource_group = "${var.presales_rg_name}"
    }
    
    byte_length = 8
}

resource "azurerm_storage_account" "qdc-storage-account" {
    name                = "diag${random_id.randomId.hex}"
    #resource_group_name = "${azurerm_resource_group.qdc.name}"
    #location            = "${azurerm_resource_group.qdc.location}"
    resource_group_name = "${var.presales_rg_name}"
    location            = "${var.azure_location}"
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags = {
        environment = "Terraform Demo"
    }
}
### Variables

# Azure Tenant id
variable "tenant_id" {
}

# Azure secret key
variable "client_id" {
}

variable "client_secret" {
}

variable "subscription_id" {
}


variable "azure_location" {
    default = "East US"
}

variable "administrator" {
}

variable "administrator_pass" {
}

variable "presales_rg_name" {
}

variable "presales_subnet_id" {
    default = "/subscriptions/e2f7b1c0-b282-4d73-b95f-8ebc778040b8/resourceGroups/IT-Infra-Mgmt/providers/Microsoft.Network/virtualNetworks/IT-Infra-Mgmt-VNet/subnets/Pre-Sales-Subnet"
}

# Postgres password for Qlik Sense administrator
variable "deloyment_name" {
    default = "qdc"
}

variable "server_hostname" {
    default = "qdc"
}
variable "qdc_rg" {
    default = "qdc"
}
# Postgres password for repository

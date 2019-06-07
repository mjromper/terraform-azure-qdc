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
}

variable "administrator" {
}

variable "administrator_pass" {
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

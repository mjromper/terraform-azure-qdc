# Using private IP as no public IP is used in Presales Azure
output "Connect-to-QDC-at" {
  value = "http://${azurerm_network_interface.qdc-nic.private_ip_address}:8080/qdc"
}


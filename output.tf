output "Connect-to-QDC-at" {
  value = "http://${azurerm_public_ip.qdc-pub-ip.fqdn}:8080/qdc"
}


resource "azurerm_virtual_machine" "qdc" {
  name                  = "${var.deloyment_name}"
  location              = "${azurerm_resource_group.qdc.location}"
  resource_group_name   = "${azurerm_resource_group.qdc.name}"
  network_interface_ids = ["${azurerm_network_interface.qdc-nic.id}"]
  vm_size               = "Standard_D2s_v3"
  delete_os_disk_on_termination = true
  storage_image_reference {
    publisher = "OpenLogic"
    offer     = "CentOS"
    sku       = "7.5"
    version   = "latest"
  }


  storage_os_disk {
    name              = "${var.deloyment_name}-osDisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }


  os_profile {
      computer_name  = "${var.server_hostname}"
      admin_username = "${var.administrator}"
      admin_password = "${var.administrator_pass}"
  }

  os_profile_linux_config {
      disable_password_authentication = true
      ssh_keys {
          path     = "/home/${var.administrator}/.ssh/authorized_keys"
          key_data = "${file("~/.ssh/id_rsa.pub")}"
      }
  }

  boot_diagnostics {
        enabled     = "true"
        storage_uri = "${azurerm_storage_account.qdc-storage-account.primary_blob_endpoint}"
    }

  tags = {
    environment = "QDC Demo"
  }

  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = "${azurerm_public_ip.qdc-pub-ip.fqdn}"
      user     = "${var.administrator}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
        "mkdir ~/install"
        ]
    }
  provisioner "file" {
    connection {
        type     = "ssh"
        host     = "${azurerm_public_ip.qdc-pub-ip.fqdn}"
        user     = "${var.administrator}"
        private_key = "${file("~/.ssh/id_rsa")}"      
    }
    source      = "install"
    destination = "~"
  }
  provisioner "remote-exec" {
    connection {
      type     = "ssh"
      host     = "${azurerm_public_ip.qdc-pub-ip.fqdn}"
      user     = "${var.administrator}"
      private_key = "${file("~/.ssh/id_rsa")}"
    }
    inline = [
        "sudo chmod u+x /home/qdc/install/scripts/*.sh",
        "sudo /home/qdc/install/scripts/bootstrap.sh",
        "sudo /home/qdc/install/scripts/postgres.sh",
        "sudo /home/qdc/install/scripts/qdc-prereqs.sh",
        "sudo /home/qdc/install/scripts/qdc-install.sh",
        ]
  }
}


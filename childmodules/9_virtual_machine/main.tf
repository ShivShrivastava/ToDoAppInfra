resource "azurerm_linux_virtual_machine" "vm" {

  name                            = var.vm_name
  resource_group_name             = var.rg_name
  location                        = var.rg_location
  size                            = var.vm_size
  admin_username                  = var.secretusername
  admin_password                  = var.secretpassword
  disable_password_authentication = false
  network_interface_ids = var.nic_id1


  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.image_publisher # Published ID from Azure Marketplace
    offer     = var.image_offer     # Product ID from Azure Marketplace
    sku       = var.image_sku       # Plan ID from Azure Marketplace
    version   = var.image_version   # Version of the image
  }
}

#   custom_data = base64encode(<<EOF
# #!/bin/bash
# apt update -y
# apt install nginx -y
# systemctl enable nginx
# systemctl start nginx
# EOF
#   )
# }

resource "azurerm_linux_virtual_machine" "vm" {
  name                            = "MinecraftServerVM"
  resource_group_name             = azurerm_resource_group.rg.name
  location                        = azurerm_resource_group.rg.location
  size                            = var.vm_size
  admin_username                  = var.vm_admin_username
  admin_password                  = var.vm_admin_password
  disable_password_authentication = false
  network_interface_ids = [
    azurerm_network_interface.netint.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }

  tags = {
    role = "server"
  }
}

output "ansible_inventory" {
  value       = "[prod]\nminecraft ansible_host=${azurerm_public_ip.pubip.ip_address} ansible_port=22 ansible_ssh_user=${var.vm_admin_username} ansible_ssh_pass=${var.vm_admin_password}"
}
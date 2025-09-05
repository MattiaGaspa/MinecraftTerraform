resource "azurerm_resource_group" "rg" {
  name     = "MinecraftServer"
  location = var.vm_location
}
variable "resource_group_name" {
  description = "Name of the resource group"
  default = "MinecraftServer"
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}

variable "vm_location" {
  description = "Location of the virtual machine"
  default = "westeurope"
}

output "vm_location" {
  value       = var.vm_location
  description = "Location of the virtual machine"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  default     = "Standard_B4ms"
}

output "vm_size" {
  value       = var.vm_size
  description = "Size of the virtual machine"
}

variable "vm_admin_username" {
  description = "Admin username"
  default     = "admin"
}

output "vm_admin_username" {
  value       = var.vm_admin_username
  description = "Admin username"
}

variable "vm_admin_password" {
  description = "Admin password"
  default     = "password"
}

output "vm_admin_password" {
  value       = var.vm_admin_password
  description = "Admin password"
  sensitive = true
}
variable "rg_name" {
  description = "Name of the Resource Group"
  default     = "MinecraftServer"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  default     = "Standard_B4ms"
}

variable "vm_admin_username" {
  description = "Admin username"
  default     = "admin"
}

variable "vm_admin_password" {
  description = "Admin password"
  default     = "password"
}
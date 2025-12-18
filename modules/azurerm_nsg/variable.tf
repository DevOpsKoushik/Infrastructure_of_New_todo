
variable "nsg_name" {
  description = "The name of the network security group."
  type        = string
  
}

variable "nsg_location" {
  description = "The location of the network security group."
  type        = string
}

variable "rg_name" {
  description = "The name of the resource group."
  type        = string  
}
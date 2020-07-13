variable "project_name" {
  type        = string
  description = "Project Name to be used as a prefix"
}

variable "main_vnet_address_space" {
  type        = string
  description = "Address Space for main Vnet"
}

variable "subnet_address_prefix" {
  type        = string
  description = "Address prefix for the  main subnet"
}

variable "default_location" {
  type        = string
  description = "default location for the project"
}

variable "int_count" {
  type        = number
  description = "Number of interfaces to create"
}


variable "rg_name" {
    type = string
}
variable "rg_location" {
    type = string
}
variable "vnet_name" {
    type = string
}
variable "address_space" {
    type = list(string)
}
variable "nsg_name" {
    type = string
}
variable "vm_name" {
    type = string
}
variable "vm_size" {
    type = string
}
variable "image_publisher" {
    type = string
}

variable "image_offer" {
    type = string
}
variable "image_sku" {
    type = string
}
variable "image_version" {
    type = string
}
variable "sql_server_name" {
    type = string
}
variable "sql_db_name" {
    type = string
}




variable "storage_account" {
    type = string
    default = "bootdiag"
    description = "Boot Diag SA"
}

variable "resource_group_name" {
    type = string
    default = "boot-diag-rg"
}

variable "vm_name" {
    type = string
    default = "boot-diag"
}

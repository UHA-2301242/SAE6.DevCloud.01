variable "proxmox_url" {
  type        = string
  description = "The URL of the Proxmox's API."

  validation {
    condition     = startswith(var.proxmox_url, "https://")
    error_message = "URL must start with https://"
  }
}

variable "proxmox_user" {
  type        = string
  description = "The user to connect to Proxmox."
}

variable "proxmox_pass" {
  type        = string
  description = "The Proxmox user's password."
  sensitive   = true
}

variable "node" {
  type    = string
  default = "pve"
}

variable "vm_gitlab_pass" {
  type        = string
  description = "The password of the Ubuntu user for gitlab"
  sensitive   = true
}

locals {
  gitlab_ip = element(element(proxmox_virtual_environment_vm.gitlab.ipv4_addresses, 1), 0)
  alpha_ip = element(element(proxmox_virtual_environment_vm.alpha.ipv4_addresses, 1), 0)
  beta_ip = element(element(proxmox_virtual_environment_vm.beta.ipv4_addresses, 1), 0)
  charlie_ip = element(element(proxmox_virtual_environment_vm.charlie.ipv4_addresses, 1), 0)
}

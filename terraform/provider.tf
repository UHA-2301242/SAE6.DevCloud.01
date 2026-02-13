terraform {
  required_providers {
    proxmox = {
      source  = "bpg/proxmox"
      version = "0.95.0"
    }
  }
}

provider "proxmox" {
  endpoint = var.proxmox_url
  username = var.proxmox_user
  password = var.proxmox_pass
  # insecure = true

  ssh {
    agent       = true
    username    = "root"
    private_key = data.local_file.ssh_user_private_key.content
    node {
      name    = "pve"
      address = "pve"
    }
  }
}


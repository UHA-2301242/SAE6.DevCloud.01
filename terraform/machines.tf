resource "proxmox_virtual_environment_vm" "gitlab" {
  name        = "gitlab"
  description = "GitLab VM instance"
  node_name   = var.node
  on_boot     = true
  tags        = ["opentofu"]

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  cpu {
    cores = 4
  }

  memory {
    dedicated = 16384
  }

  purge_on_destroy                     = false
  delete_unreferenced_disks_on_destroy = false
}

resource "proxmox_virtual_environment_vm" "alpha" {
  name        = "alpha"
  description = "Alpha Instance - Master K8S instance"
  node_name   = var.node
  on_boot     = true
  tags        = ["opentofu", "k8s-master"]

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  purge_on_destroy                     = false
  delete_unreferenced_disks_on_destroy = false
}

resource "proxmox_virtual_environment_vm" "beta" {
  name        = "beta"
  description = "Beta Instance - Worker K8S instance"
  node_name   = var.node
  on_boot     = true
  tags        = ["opentofu", "k8s-worker"]

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  purge_on_destroy                     = false
  delete_unreferenced_disks_on_destroy = false
}

resource "proxmox_virtual_environment_vm" "charlie" {
  name        = "charlie"
  description = "Charlie Instance - Worker K8S instance"
  node_name   = var.node
  on_boot     = true
  tags        = ["opentofu", "k8s-worker"]

  clone {
    vm_id = proxmox_virtual_environment_vm.ubuntu_template.id
  }

  agent {
    enabled = true
  }

  purge_on_destroy                     = false
  delete_unreferenced_disks_on_destroy = false
}

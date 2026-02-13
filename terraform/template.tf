resource "proxmox_virtual_environment_file" "user_data_cloud_config" {
  content_type = "snippets"
  datastore_id = "local"
  node_name    = var.node

  source_raw {
    data      = templatefile("./assets/cloud-init.yml", { "ssh-key" : trimspace(data.local_file.ssh_user_public_key.content), "ssh-key-ansible" : trimspace(data.local_file.ssh_ansible_public_key.content) })
    file_name = "ubuntu-cloud-init.yml"
  }
}

resource "proxmox_virtual_environment_vm" "ubuntu_template" {
  name      = "ubuntu-template-cloudinit"
  node_name = var.node

  template = true
  started  = false

  machine     = "q35"
  bios        = "ovmf"
  description = "Ubuntu template"

  cpu {
    cores = 2
  }

  memory {
    dedicated = 4096
  }

  efi_disk {
    datastore_id = "local-lvm"
    type         = "4m"
  }

  disk {
    datastore_id = "local-lvm"
    file_id      = proxmox_virtual_environment_download_file.ubuntu_noble_img.id
    interface    = "virtio0"
    iothread     = true
    discard      = "on"
    size         = 30
  }

  initialization {
    dns {
      servers = ["1.1.1.1"]
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
    }

    user_data_file_id = proxmox_virtual_environment_file.user_data_cloud_config.id
  }

  network_device {
    bridge = "vmbr0"
  }

  purge_on_destroy                     = false
  delete_unreferenced_disks_on_destroy = false
}

resource "proxmox_virtual_environment_download_file" "ubuntu_noble_img" {
  content_type = "iso"
  datastore_id = "local"
  node_name    = var.node

  url = "https://cloud-images.ubuntu.com/releases/noble/release/ubuntu-24.04-server-cloudimg-amd64.img"
}

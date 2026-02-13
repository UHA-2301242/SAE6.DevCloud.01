data "local_file" "ssh_user_public_key" {
  filename = "../keys/user.key.pub"
}

data "local_file" "ssh_user_private_key" {
  filename = "../keys/user.key"
}

data "local_file" "ssh_ansible_public_key" {
  filename = "../keys/ansible.key.pub"
}

data "local_file" "ssh_ansible_private_key" {
  filename = "../keys/ansible.key"
}

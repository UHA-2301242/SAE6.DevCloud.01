output "gitlab_ip" {
  value = local.gitlab_ip
}

output "alpha_ip" {
  value = local.alpha_ip
}

output "beta_ip" {
  value = local.beta_ip
}

output "charlie_ip" {
  value = local.charlie_ip
}

resource "local_file" "output_file" {
  content = templatefile("./assets/inv.ini.tmpl", {
    gitlab_ip = local.gitlab_ip,
    alpha_ip = local.alpha_ip,
    beta_ip = local.beta_ip,
    charlie_ip = local.charlie_ip,
  })
  filename = "../ansible/inventory.ini"
}

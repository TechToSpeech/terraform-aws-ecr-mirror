locals {
  module_path = replace(path.module, "\\", "/")
}

resource "null_resource" "docker_pullpush" {

  triggers = {
    shell_hash = sha256("${var.docker_source}${var.ecr_repo_name}${var.architecture}${var.ecr_repo_tag}")
  }
  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "${local.module_path}/docker_pullpush.sh ${var.docker_source} ${var.aws_region} ${var.aws_account_id} ${var.ecr_repo_name} ${var.ecr_repo_tag} ${var.aws_profile} ${var.architecture}"
  }
}
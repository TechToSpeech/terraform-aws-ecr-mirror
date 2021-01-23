resource "null_resource" "docker_pullpush" {

  triggers = {
    shell_hash = sha256("${var.docker_source}${var.ecr_repo_name}${var.ecr_repo_tag}")
  }
  provisioner "local-exec" {
      command = "${abspath(path.module)}/docker_pullpush.sh ${var.docker_source} ${var.aws_region} ${var.aws_account_id} ${var.ecr_repo_name} ${var.ecr_repo_tag} ${var.aws_profile}"
  }
}
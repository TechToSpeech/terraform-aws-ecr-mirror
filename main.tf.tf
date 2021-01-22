resource "null_resource" "wordpress_pullpush" {

  triggers = {
    shell_hash = sha256(var.docker_source)
  }
  provisioner "local-exec" {
      // ARGs to script are source image, region, AWS Account ID, aws_profile
      command = "${abspath(path.module)}/docker_pullpush.sh ${var.docker_source} ${var.aws_region} ${var.aws_account_id} ${var.aws_profile}"
  }
}
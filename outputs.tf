output "ecr_repo_url" {
    value = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo_name}"
    description = "The repository URL of the pushed image."
}

output "ecr_repo_url_tag" {
    value = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo_name}:${var.ecr_repo_tag}"
    description = "The repository URL with tag of the pushed image."
}
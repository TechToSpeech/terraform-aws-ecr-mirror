output "ecr_repo_arn" {
    value = "${var.aws_account_id}.dkr.ecr.${var.aws_region}.amazonaws.com/${var.ecr_repo_name}:${var.ecr_repo_tag}"
    description = "The repository URL with tag of the pushed image."
}
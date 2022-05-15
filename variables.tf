variable "aws_region" {
  description = "The region in which the ECR repository is located."
}

variable "docker_source" {
  description = "The source location of the Docker image being pulled."
}

variable "aws_account_id" {
  description = "The AWS Account ID where the ECR repository is located."
}

variable "aws_profile" {
  description = "The awscli profile name (located in the ~/.aws/credentials file) used to authenticate the ECR login and push (Optional)"
  default     = ""
}

variable "ecr_repo_name" {
  description = "The name of the ECR repository being pushed to."
}

variable "ecr_repo_tag" {
  description = "The tag of the ECR repository image being pushed."
}

variable "architecture" {
  description = "The override flag to pull an image of a specific architecture. e.g. `linux/arm64/v8`"
  default = ""
}
# Terraform Module: AWS ECR Mirror

A Terraform module that performs a local docker pull and push to a given AWS ECR repository

## Use Case
In late 2020, Docker Hub announced that the Hub service would begin limiting the rate at which images can be pulled under their anonymous and free plans. 

The [AWS recommendation](https://aws.amazon.com/blogs/containers/advice-for-customers-dealing-with-docker-hub-rate-limits-and-a-coming-soon-announcement/) for those not wishing to upgrade to a paid plan is to mirror the Dockerhub image to their own AWS ECR repository. 

This simple task requires a basic 'pull from Dockerhub-push to ECR' loop for which there exists no simple bootstrapping solution. The typical use case is a new ECR repository that would look to use a Dockerhub image as its 'base' image which can then be used in subsequent builds without the pull limits. 

This module is a simple terraform `local-exec` provisioner which runs the required awscli and docker push commands to ECR, and can be woven in to your existing set-up. 

## Requirements

- aws-cli v2 installed and configured with a named [profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) that has permissions to push to the desired ECR repository
- [Docker installed](https://docs.docker.com/engine/install/) on the machine executing terraform, and permissions for the user executing terraform to run docker commands (e.g. by adding the user to the 'docker' user group)

## Idempotence

As this module is essentially running a series of bash commands, it ensures idempotence by triggering only when any of the values of the `docker_source`, `ecr_repo_name` or `ecr_repo_tag` variables are changed.

## Usage Example

```
module "ecr_mirror" {
  source  = "TechToSpeech/ecr-mirror/aws"
  version = "0.0.8"
  architecture = "linux/arm64/v8"
  aws_account_id = "123456544225"
  aws_region = "eu-west-1"
  docker_source = "wordpress:php7.4-apache"
  aws_profile = "default"
  ecr_repo_name = "php_wordpress"
  ecr_repo_tag = "base"
}
```

Consider adding an additional `depends_on` attribute if you are using this module in combination with a Terraform resource that also creates the ECR repository being pushed to. 

## License
Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.
<!-- BEGIN_TF_DOCS -->
# Terraform Module: AWS ECR Mirror

A Terraform module that performs a local docker pull and push to a given AWS ECR repository

## Use Case
In late 2020, Docker Hub announced that the Hub service would begin limiting the rate at which images can be pulled under their anonymous and free plans.

The [AWS recommendation](https://aws.amazon.com/blogs/containers/advice-for-customers-dealing-with-docker-hub-rate-limits-and-a-coming-soon-announcement/) for those not wishing to upgrade to a paid plan is to mirror the Dockerhub image to their own AWS ECR repository.

This simple task requires a basic 'pull from Dockerhub-push to ECR' loop for which there exists no simple bootstrapping solution. The typical use case is a new ECR repository that would look to use a Dockerhub image as its 'base' image which can then be used in subsequent builds without the pull limits.

This module is a simple terraform `local-exec` provisioner which runs the required awscli and docker push commands to ECR, and can be woven in to your existing set-up.

## Requirements

- aws-cli v2 installed and configured with a named [profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) that has permissions to push to the desired ECR repository
- [Docker installed](https://docs.docker.com/engine/install/) on the machine executing terraform, and permissions for the user executing terraform to run docker commands (e.g. by adding the user to the 'docker' user group)
- Experimental mode enabled if you wish to use `architecture` argument. See [Leverage multi-CPU architecture support](https://docs.docker.com/desktop/multi-arch/) in Docker documentation.

## Idempotence

As this module is essentially running a series of bash commands, it ensures idempotence by triggering only when any of the values of the `docker_source`, `ecr_repo_name` or `ecr_repo_tag` variables are changed.

## Usage Example

```
module "ecr_mirror" {
  source  = "TechToSpeech/ecr-mirror/aws"
  version = "0.0.8"
  architecture = "linux/arm64/v8"
  aws_account_id = "123456544225"
  aws_region = "eu-west-1"
  docker_source = "wordpress:php7.4-apache"
  aws_profile = "default"
  ecr_repo_name = "php_wordpress"
  ecr_repo_tag = "base"
}
```

Consider adding an additional `depends_on` attribute if you are using this module in combination with a Terraform resource that also creates the ECR repository being pushed to.

## License
Licensed under the Apache License, Version 2.0 (the "License").

You may obtain a copy of the License at apache.org/licenses/LICENSE-2.0.

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" basis, without WARRANTIES or conditions of any kind, either express or implied.

See the License for the specific language governing permissions and limitations under the License.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architecture"></a> [architecture](#input\_architecture) | The override flag to pull an image of a specific architecture. e.g. `linux/arm64/v8` | `string` | `""` | no |
| <a name="input_aws_account_id"></a> [aws\_account\_id](#input\_aws\_account\_id) | The AWS Account ID where the ECR repository is located. | `any` | n/a | yes |
| <a name="input_aws_profile"></a> [aws\_profile](#input\_aws\_profile) | The awscli profile name (located in the ~/.aws/credentials file) used to authenticate the ECR login and push (Optional) | `string` | `""` | no |
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The region in which the ECR repository is located. | `any` | n/a | yes |
| <a name="input_docker_source"></a> [docker\_source](#input\_docker\_source) | The source location of the Docker image being pulled. | `any` | n/a | yes |
| <a name="input_ecr_repo_name"></a> [ecr\_repo\_name](#input\_ecr\_repo\_name) | The name of the ECR repository being pushed to. | `any` | n/a | yes |
| <a name="input_ecr_repo_tag"></a> [ecr\_repo\_tag](#input\_ecr\_repo\_tag) | The tag of the ECR repository image being pushed. | `any` | n/a | yes |
## Modules

No modules.
## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ecr_repo_arn"></a> [ecr\_repo\_arn](#output\_ecr\_repo\_arn) | The repository URL with tag of the pushed image. |
## Requirements

No requirements.
## Resources

| Name | Type |
|------|------|
| [null_resource.docker_pullpush](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
<!-- END_TF_DOCS -->
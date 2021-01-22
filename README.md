# Terraform Module: AWS ECR Mirror

A Terraform module that performs a local docker pull and push to a given AWS ECR repository

## Use Case
In late 2020, Docker Hub announced that the Hub service would begin limiting the rate at which images can be pulled under their anonymous and free plans. 

The [AWS recommendation](https://aws.amazon.com/blogs/containers/advice-for-customers-dealing-with-docker-hub-rate-limits-and-a-coming-soon-announcement/) for those not wishing to upgrade to a paid plan is to mirror the Dockerhub image to their own AWS ECR repository. 

This simple task requires a basic 'pull from Dockerhub-push to ECR' loop for which there exists no good bootstrapping solution (outside of a convolution such as a CodeBuild pipeline) for a new ECR repository that would look to use a Dockerhub image as its 'base' image which can then be used in subsequent builds without the pull limits. 

This module is a simple terraform `local-exec` provisioner which runs the required awscli and docker push commands to ECR, and can be woven in to your existing set-up. 

## Requirements

- aws-cli installed and configured with a named [profile](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-profiles.html) that has permissions to push to the desired ECR repository
- [Docker installed](https://docs.docker.com/engine/install/) on the machine executing terraform, and permissions for the user executing terraform to run docker commands (e.g. by adding the user to the 'docker' user group)

## Usage Example

```
module "ecr_mirror" {
  source = "./docker_init"
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
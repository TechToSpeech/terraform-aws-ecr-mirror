# Changelog

## 0.0.8

Added support for overriding the desired platform architecture of the docker image. (Note: Experimental mode must be enabled on your local docker client)

## 0.0.7

Added bash as command interpreter of local-exec.

## 0.0.6

Added escaping of local-exec command path to handle Windows paths.

## 0.0.5

Remove region bias for push

## 0.0.4

Bugfix on executability of script

## 0.0.3

Minor usage documentation update

## 0.0.2

Made provision of AWS profile credential optional. If not specified the awscli will look for credentials in order from the [usual sources](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html).

## 0.0.1

Initial release of ecs-mirror module
#!/bin/bash

if [[ ${#6} -gt 0 ]]; then
    profile="--profile $6"
fi

if [[ ${#7} -gt 0 ]]; then
    platform="--platform $7"
fi

docker pull $platform $1
aws ecr get-login-password --region $2 $profile | docker login --username AWS --password-stdin $3.dkr.ecr.$2.amazonaws.com
docker tag $1 $3.dkr.ecr.$2.amazonaws.com/$4:$5
docker push $3.dkr.ecr.$2.amazonaws.com/$4:$5
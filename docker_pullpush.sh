docker pull $1
aws ecr get-login-password --region $2 --profile $4 | docker login --username AWS --password-stdin $3.dkr.ecr.$2.amazonaws.com
docker tag $1 $3.dkr.ecr.eu-west-1.amazonaws.com/$5:$6
docker push $3.dkr.ecr.eu-west-1.amazonaws.com/$5:$6
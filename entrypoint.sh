#!/usr/bin/env sh

set -e

export AWS_ACCESS_KEY_ID="${INPUT_AWS_ACCESS_KEY_ID}"
export AWS_SECRET_ACCESS_KEY="${INPUT_AWS_SECRET_ACCESS_KEY}"

echo "AWSCLI version: $(aws --version)"

echo "Updated kubeconfig with the AWS credentials."
aws eks --region "$INPUT_AWS_REGION" update-kubeconfig --name "$INPUT_CLUSTER_NAME"

echo "Running commands..."
result=$(sh -c "${@}")
echo "::set-output name=result::${result}"

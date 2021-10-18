#!/usr/bin/env bash

echo "Add AWS Credentials"
echo "${IFOOD_LITE_SERVICEACCOUNT}" | base64 -d -i > ~/.aws/credentials

echo "Set environment"
echo "IFOOD_LITE_${IFOOD_LITE_ENV^^}_CLUSTER_NAME"
IFOOD_LITE_CLUSTER_NAME=$(aws ssm get-parameters --names "IFOOD_LITE_${IFOOD_LITE_ENV^^}_CLUSTER_NAME" --region us-east-1 --query "Parameters[0].Value" | sed 's/"//g' | sed 's/\\//g')
IFOOD_LITE_SERVICE_ACCOUNT_NAME=$(aws ssm get-parameters --names "IFOOD_LITE_${IFOOD_LITE_ENV^^}_SERVICE_ACCOUNT_NAME" --region us-east-1 --query "Parameters[0].Value" | sed 's/"//g' | sed 's/\\//g')
echo "${IFOOD_LITE_SERVICE_ACCOUNT_NAME}"
IFOOD_LITE_SERVICE_ACCOUNT_ROLE_ARN=$(aws ssm get-parameters --names "IFOOD_LITE_${IFOOD_LITE_ENV^^}_SERVICE_ACCOUNT_ROLE_ARN" --region us-east-1 --query "Parameters[0].Value" | sed 's/"//g' | sed 's/\\//g')
echo "${IFOOD_LITE_SERVICE_ACCOUNT_ROLE_ARN}"

echo "Set context"
aws eks --region us-east-1 update-kubeconfig --name "${IFOOD_LITE_CLUSTER_NAME}"

echo "${IFOOD_LITE_CLUSTER_NAME}"
CLUSTER_REGION=$(kubectl config current-context | cut -d ":" -f 4)
echo "${CLUSTER_REGION}"

sleep 5s

echo "Run commands"
echo "$@"

"$@"

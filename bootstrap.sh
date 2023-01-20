#!/usr/bin/env bash
REGION="us-east-1"
aws s3api create-bucket \
	--region "${REGION}" \
	--create-bucket-configuration LocationConstraint="${REGION}" \
	--bucket "diplom-project-tf-state" \
	--profile diplomproject

aws dynamodb create-table \
	--region "${REGION}" \
	--table-name diplomproject_tf_state \
	--attribute-definitions AttributeName=LockID,AttributeType=S \
	--key-schema AttributeName=LockID,KeyType=HASH \
	--provisioned-throughput ReadCapacityUnits=1,WriteCapacityUnits=1 \
	--profile diplomproject
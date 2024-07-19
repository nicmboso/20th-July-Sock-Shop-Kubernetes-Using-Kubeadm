#!/bin/bash

# Variables
BUCKET_NAME="team19-nic-s3bucket"
DYNAMODB_TABLE_NAME="team19-nic-DynamoDB"
REGION="eu-west-2"
PROFILE="team2"

# Delete all objects in the S3 bucket
echo "Deleting all objects in S3 bucket: $BUCKET_NAME"
aws s3 rm s3://$BUCKET_NAME --recursive --profile $PROFILE

# Delete the S3 bucket
echo "Deleting S3 bucket: $BUCKET_NAME"
aws s3api delete-bucket --bucket $BUCKET_NAME --region $REGION

# Delete the DynamoDB table
echo "Deleting DynamoDB table: $DYNAMODB_TABLE_NAME"
aws dynamodb delete-table --table-name $DYNAMODB_TABLE_NAME --region $REGION

# Wait for the DynamoDB table to be deleted
echo "Waiting for DynamoDB table to be deleted"
aws dynamodb wait table-not-exists --table-name $DYNAMODB_TABLE_NAME --region $REGION --profile $PROFILE

echo "S3 bucket and DynamoDB table deleted successfully."

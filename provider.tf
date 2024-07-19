provider "aws" {
  region  = "eu-west-2"
  profile = "team2"
}
terraform {
  backend "s3" {
    bucket         = "team19-nic-s3bucket"
    key            = "infra/tfstate"
    dynamodb_table = "team19-nic-DynamoDB"
    region         = "eu-west-2"
    # encrypt = true
    # profile = "team2"
  }
}
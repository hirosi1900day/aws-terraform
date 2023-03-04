terraform {
  backend "s3" {
    bucket = "terraform-github-action-s3-hiroz"
    key    = "terraform.tfstate"
    region = "ap-northeast-1"

  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  region = "ap-northeast-1"
}

module "dynamodb" {
  source = "../module/dynamodb"
  prefix = "sample1"
}

module "iam" {
  source                  = "../module/iam"
  prefix                  = "sample1"
  arexa_list_table-arn = module.dynamodb.employee_list_table.arn
}
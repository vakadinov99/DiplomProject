terraform {
  required_version = "~> 1.3.7"


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    encrypt        = "true"
    bucket         = "diplom-project-tf-state"
    key            = "env-prod"
    region         = "us-east-1"
    dynamodb_table = "diplomproject_tf_state"
  }
}

provider "aws" {
  region                  = "us-east-1"
}



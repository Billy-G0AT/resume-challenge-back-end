terraform {
  backend "s3" {
    bucket         = "terraform-state-resume"
    key            = "terraform/state/terraform.tfstate"
    region         = "us-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.14.0"
    }

    archive = {
      source  = "hashicorp/archive"
      version = "~> 2.4.0"
    }
  }

  required_version = "~> 1.7.5"
}

provider "aws" {
  region = "us-west-1"
}

# This Region For Certificate Resource
provider "aws" {
  region = "us-east-1"
  alias  = "east"
}

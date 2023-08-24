terraform {
  backend "s3" {
    bucket = "terraform-state-resume"
    key    = "terraform/state/terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "terraform-state-lock"
    encrypt = true
  }
}


provider "aws" {
  region = "us-west-1"
}

# This Region For Certificate Resource
provider "aws" {
  region = "us-east-1"
  alias = "east"
}

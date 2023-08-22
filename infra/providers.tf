provider "aws" {
  region = "us-west-1"
}

# This Region For Certificate Resource
provider "aws" {
  region = "us-east-1"
  alias = "east"
}

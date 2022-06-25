provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "kovalevskyi-remote-tfstate"
    key    = "cloudx-associate-aws-devops-12/terraform.tfstate"
    region = "eu-central-1"
  }
}


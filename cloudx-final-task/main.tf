provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "cdp-remote-tfstate"
    key    = "cloudx-associate-aws-devops-12-yaroslav-k/terraform.tfstate"
    region = "eu-north-1"
  }
}


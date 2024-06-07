terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.53.0"
    }
  }
  backend "s3" {
    bucket = "yk-tfstate"
    key    = "pet/terraform.tfstate"
    region = "eu-central-1"
  }
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Terraform   = "true"
      Environment = terraform.workspace
      Project     = var.project
    }
  }
}

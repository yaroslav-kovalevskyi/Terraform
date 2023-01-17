// These files provide end-to-end infrastructure for multiple Cloufronts from one S3 bucket.
// Subdirectories in bucket correspond to subdomains, which have to be specified in variable "sub_domains"
// Bucket files have to be uploaded only through AWS CLI or Terraform code, not either AWS Web Console.
// Milestone passed on Jan 15, 2023. Owner Yaroslav Kovalevskyi
// To be improved...
// #russiaIsATerroristState

provider "aws" {
  region = "us-east-1"

  default_tags {
    tags = {
      terraform = "true"
      Owner     = "YK"
      Environment = var.environment
    }
  }
}

terraform {
  backend "s3" {
    bucket = "kovalevskyi-remote-tfstate"
    key    = "cloudfront/terraform.tfstate"
    region = "eu-central-1"
  }
}

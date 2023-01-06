provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  region = "ap-northeast-3"
  alias  = "bucket_location"
}

terraform {
  backend "s3" {
    bucket = "kovalevskyi-remote-tfstate"
    key    = "cloudfront/terraform.tfstate"
    region = "eu-central-1"
  }
}

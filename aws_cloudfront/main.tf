provider "aws" {
  region = "us-east-1" # <<<

  default_tags {
    tags = {
      terraform = "true"
      Owner     = "YK"
    }
  }
}

#Need to use if bucket is located not in us-east-1 region
provider "aws" {
  region = "ap-northeast-3" # <<<
  alias  = "bucket_location"
}

terraform {
  backend "s3" {
    bucket = "kovalevskyi-remote-tfstate"   # <<<
    key    = "cloudfront/terraform.tfstate" # <<<
    region = "eu-central-1"                 # <<<
  }
}

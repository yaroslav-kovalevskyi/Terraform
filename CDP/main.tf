#----------------------------------------------------------
# Provision Highly Available instance and database in any Region
# Create:
#    - Virtual Private Cloud
#    - Security Groups for Nextcloud and Database
#    - Separated subnets for Nextcloud (public) and Database (private)
#    - Database instance MySQL 5.7 (with preventing destroy)
#    - Launch Configuration with Auto AMI Lookup (Amazon Linux)
#    - Auto Scaling Group for Nextcloud instance
#    - Classic Load Balancer for Nextcloud subnet
#-----------------------------------------------------------

provider "aws" {
  region = var.region
}

terraform {
  backend "s3" {
    bucket = "kovalevskyi-remote-tfstate"
    key    = "cdp/terraform.tfstate"
    region = "eu-central-1"
  }
}

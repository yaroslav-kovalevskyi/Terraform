provider "aws" {
  region = "eu-north-1"
}

resource "aws_vpc" "cdp_vpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_hostnames = true

  tags = {
    Name = "[CDP] VPC"
  }
}

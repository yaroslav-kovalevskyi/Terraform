provider "aws" {

}

resource "aws_vpc" "Nextcloud_plus_DB" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "Nextcloud DB Prometheus Grafana"
  }
}

data "aws_availability_zones" "available" {
  state = "available"
}

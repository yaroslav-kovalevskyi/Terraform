data "aws_route53_zone" "selected" {
  name         = var.domain_name
  private_zone = false
}

# data "aws_region" "current" {}

data "aws_ami" "ubuntu24lts" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-202412*"]
  }
}

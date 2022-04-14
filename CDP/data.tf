data "aws_ami" "latest_amazon_linux" {
  owners      = ["amazon"]
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

data "aws_ssm_parameter" "cdp_rds_username" {
  name = "/cdp/db_username"

  depends_on = [aws_ssm_parameter.cdp_rds_username]
}

data "aws_availability_zones" "available" {}

data "aws_ssm_parameter" "cdp_rds_password" {
  name = "/cdp/db_password"

  depends_on = [aws_ssm_parameter.cdp_rds_password]
}
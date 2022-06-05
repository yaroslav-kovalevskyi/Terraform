data "aws_availability_zones" "available" {}

data "http" "myip" {
  url = "http://ipv4.icanhazip.com"
}

data "aws_ssm_parameter" "db_username" {
  name       = "/ghost/dbusername"
  depends_on = [aws_ssm_parameter.db_username]
}

data "aws_ssm_parameter" "db_password" {
  name       = "/ghost/dbpassw"
  depends_on = [aws_ssm_parameter.db_password]
}
resource "aws_db_instance" "mySQL" {
  allocated_storage   = 10
  engine              = "mySQL"
  engine_version      = "5.7"
  instance_class      = var.db_instance_class
  identifier          = "cdp-nextcloud-database"
  name                = var.db_name
  username            = data.aws_ssm_parameter.cdp_rds_username.value
  password            = data.aws_ssm_parameter.cdp_rds_password.value
  skip_final_snapshot = true
  apply_immediately   = true

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.RDS_Security_Group.id]

  tags = {
    Name = "${var.project}_MySQL_Database"
  }
  lifecycle {
    prevent_destroy = false
  }
}

resource "aws_ssm_parameter" "cdp_rds_username" {
  name        = "/cdp/db_username"
  description = "Username for RDS MySQL"
  type        = "String"
  value       = "${var.project}_db_admin"
}

resource "random_string" "cdp_rds_pass" {
  length           = 12
  override_special = "!#$"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "aws_ssm_parameter" "cdp_rds_password" {
  name        = "/cdp/db_password"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.cdp_rds_pass.result
}
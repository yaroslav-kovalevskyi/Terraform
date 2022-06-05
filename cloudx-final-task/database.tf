resource "aws_db_instance" "ghost" {
  allocated_storage   = 20
  storage_type        = "gp2"
  engine              = "mySQL"
  engine_version      = var.db_engine_version
  instance_class      = var.db_instance_class
  identifier          = "ghost"
  db_name             = var.db_name
  username            = data.aws_ssm_parameter.db_username.value
  password            = data.aws_ssm_parameter.db_password.value
  skip_final_snapshot = true
  apply_immediately   = true
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.mysql.id]
  tags = {
    Name = "${var.project}_MySQL_Database"
  }
}

resource "aws_ssm_parameter" "db_username" {
  name        = "/ghost/dbusername"
  description = "Username for RDS MySQL"
  type        = "String"
  value       = "${var.project}_db_admin"
}

resource "random_string" "cloudx_db_pass" {
  length           = 12
  override_special = "!#$"
  min_lower        = 1
  min_upper        = 1
  min_numeric      = 1
  min_special      = 1
}

resource "aws_ssm_parameter" "db_password" {
  name        = "/ghost/dbpassw"
  description = "Master Password for RDS MySQL"
  type        = "SecureString"
  value       = random_string.cloudx_db_pass.result
}
resource "aws_db_instance" "mySQL" {
  allocated_storage   = 10
  engine              = "mySQL"
  engine_version      = "5.7"
  instance_class      = var.db_instance_class
  identifier          = "cdp-nextcloud-database"
  name                = var.db_name
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true

  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.RDS_Security_Group.id]

  tags = {
    Name = "CDP_MySQL_Database"
  }
  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_db_instance" "mySQL" {
  allocated_storage    = 10
  engine               = "mySQL"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  name                 = "cdp_db_mySQL"
  username             = "cdp_admin"
  password             = "p4$$WORD"
  skip_final_snapshot  = true

  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.RDS_Security_Group.id]

  tags = {
    Name = "[CDP] MySQL Database"
  }
}
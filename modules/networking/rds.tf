######################### Database Subnet Group #########################

resource "aws_db_subnet_group" "db_subnet_group" {
  name        = "db-subnet-group"
  subnet_ids  = aws_subnet.database.*.id
  description = "DB subnet group that contains all database subnet, created in this region"

  tags = {
    Name = "/${var.environment}/ Database Subnet Group"
  }
}

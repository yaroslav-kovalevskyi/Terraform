######################### Database Subnet Group #########################

resource "aws_db_subnet_group" "default" {
  name        = "${terraform.workspace}-db-subnet-group"
  subnet_ids  = aws_subnet.database.*.id
  description = "DB subnet group that contains all database subnet, created in this region"

  tags = {
    Name = "${var.environment} / ${var.project} Database Subnet Group"
  }
}

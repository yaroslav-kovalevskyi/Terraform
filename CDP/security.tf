resource "aws_security_group" "Nextcloud_Security_Group" {
  name   = "Nextcloud_Dynamic_Security_Group"
  vpc_id = aws_vpc.main.id

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Nextcloud Security Group"
  }
}

resource "aws_security_group" "RDS_Security_Group" {
  name   = "RDS_Security_Group"
  vpc_id = aws_vpc.main.id

  ingress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.Nextcloud_Security_Group.id]
  }

  egress {
    from_port       = 3306
    protocol        = "tcp"
    to_port         = 3306
    security_groups = [aws_security_group.Nextcloud_Security_Group.id]
  }

  tags = {
    Name = "DB Private Security Group"
  }
}
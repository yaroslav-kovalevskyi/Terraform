resource "aws_security_group" "Nextcloud_Security_Group" {
  name   = "Nextcloud_Dynamic_Security_Group"
  vpc_id = aws_vpc.cdp_vpc.id

  dynamic "ingress" {
    for_each = [80, 443, 22]
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
}

resource "aws_security_group" "RDS_Security_Group" {
  name = "RDS_Security_Group"

  ingress {
    from_port = 0
    protocol  = ""
    to_port   = 0
  }

  egress {
    from_port = 0
    protocol  = ""
    to_port   = 0
  }
}
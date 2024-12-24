######################## Wordpress DB ########################
resource "aws_security_group" "database" {
  description = "Security group for database. Accessible only from Wordpress Server"
  name        = "database_secured"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.wellknown_ip
    content {
      description = ingress.key
      cidr_blocks = [ingress.value]
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
    }
  }

  ingress {
    description     = "Open MySQL port for Wordpress Server"
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.wordpress.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${terraform.workspace} | ${var.project} Database Security Group"
  }
}

######################## Wordpress SG ########################

resource "aws_security_group" "wordpress" {
  description = "Security group for wordpress. Accessible fromwell known IP addresses"
  name        = "wordpress_secured"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.wellknown_ip
    content {
      description = ingress.key
      cidr_blocks = [ingress.value]
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
    }
  }

  ingress {
    description = "Open MySQL port for Wordpress Server"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${terraform.workspace} | ${var.project} Wordpress Security Group"
  }
}

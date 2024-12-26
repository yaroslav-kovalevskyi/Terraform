######################## Wordpress DB ########################
resource "aws_security_group" "database" {
  description = "Security group for database. Accessible only from Wordpress Server"
  name        = "database_secured"
  vpc_id      = var.vpc_properties.vpc_id

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
    Name = "${terraform.workspace} | ${var.general.project} Database Security Group"
  }
}

######################## Wordpress SG ########################

resource "aws_security_group" "wordpress" {
  description = "Security group for wordpress. Accessible from well known IP addresses"
  name        = "wordpress_secured"
  vpc_id      = var.vpc_properties.vpc_id

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

  dynamic "ingress" {
    for_each = var.public_ports
    content {
      description = ingress.key
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
    }
  }

  dynamic "ingress" {
    for_each = var.internal_ports
    content {
      description = ingress.key
      cidr_blocks = ["${var.vpc_properties.cidr_block}"]
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${terraform.workspace} | ${var.general.project} Wordpress Security Group"
  }
}

######################## Redis SG ########################

resource "aws_security_group" "redis" {
  description = "Security group for Reds. Accessible only from WordPress Server"
  name        = "redis_secured"
  vpc_id      = var.vpc_properties.vpc_id

  ingress {
    description     = "Open Redis port. Accessible only from WP and DB servers"
    from_port       = 6379
    to_port         = 6379
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
    Name = "${terraform.workspace} | ${var.general.project} Redis Security Group"
  }
}

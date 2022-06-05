resource "aws_security_group" "ec2" {
  name        = "ec2_pool"
  description = "Allow access for EC2 instances"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  /*ingress {
    from_port       = 2368
    to_port         = 2368
    protocol        = "tcp"
    cidr_blocks = aws_alb
  } */
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.project} EC2"
  }
}

resource "aws_security_group" "fargate" {
  name        = "fargate_pool"
  description = "Allow access for Fargate instances"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  /*ingress {
    from_port       = 2368
    to_port         = 2368
    protocol        = "tcp"
    cidr_blocks = aws_alb
  } */
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = {
    Name = "${var.project} Fargate"
  }
}

resource "aws_security_group" "mysql" {
  name        = "mysql"
  description = "Defines access to ghost DB"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id, aws_security_group.fargate.id]
  }
  tags = {
    Name = "${var.project} MySQL"
  }
}

resource "aws_security_group" "efs" {
  name        = "efs"
  description = "Defines access to EFS mount points"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port       = 2049
    to_port         = 2049
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2.id, aws_security_group.fargate.id]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  tags = {
    Name = "${var.project} EFS"
  }
}

resource "aws_security_group" "alb" {
  name        = "alb"
  description = "Defines access to ALB"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.ec2.id, aws_security_group.fargate.id]
  }
  tags = {
    Name = "${var.project} ALB"
  }

}

resource "aws_security_group" "vpc_endpoint" {
  name        = "vpc_endpoint"
  description = "Defines access to VPC endpoints"
  vpc_id      = aws_vpc.main.id
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.main.cidr_block]
  }
  tags = {
    Name = "${var.project} VPCs endpoint"
  }
}
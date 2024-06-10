#################### Instance ####################

resource "aws_instance" "ubuntu" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.ubuntu.id
  key_name        = aws_key_pair.generated.key_name
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.ec2.id, aws_security_group.alb.id]
  user_data       = file("${path.module}/ubuntu_bootstrap.sh")

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.project} | Linux Ubuntu"
  }
}

#################### SSH Key Generation ####################

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated" {
  key_name   = "${terraform.workspace}_${lower(var.project)}"
  public_key = tls_private_key.rsa.public_key_openssh
}

resource "local_file" "ssh_key" {
  content              = tls_private_key.rsa.private_key_pem
  filename             = "../ssh/${terraform.workspace}_${lower(var.project)}.pem"
  directory_permission = "0400"
  file_permission      = "0400"
}

#################### ELB ####################

# resource "aws_lb" "test" {
#   name               = "default-alb"
#   internal           = false
#   load_balancer_type = "application"
#   security_groups    = [aws_security_group.alb.id]
#   subnets            = var.subnets
# }

# #################### Listeners ####################

# resource "aws_lb_listener" "http" {
#   load_balancer_arn = aws_lb.front_end.arn
#   port              = "80"
#   protocol          = "HTTP"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.grafana.arn
#   }
#   # default_action {
#   #   type = "redirect"

#   #   redirect {
#   #     port        = "443"
#   #     protocol    = "HTTPS"
#   #     status_code = "HTTP_301"
#   #   }
#   # }
# }

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.front_end.arn
#   port              = "443"
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = "arn:aws:iam::187416307283:server-certificate/test_cert_rab3wuqwgja25ct3n4jdj2tzu4"

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.grafana.arn
#   }
# }

#################### Target groups ####################

resource "aws_lb_target_group" "grafana" {
  vpc_id      = var.vpc_id
  name        = "grafana-3k"
  port        = 3000
  protocol    = "HTTP"
  target_type = "instance" #"alb"

  health_check {
    matcher = "200-499"
  }
}

resource "aws_lb_target_group_attachment" "to_grafana" {
  target_group_arn = aws_lb_target_group.grafana.arn
  target_id        = aws_instance.ubuntu.id
}

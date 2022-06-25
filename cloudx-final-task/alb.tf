resource "aws_lb" "cloudx" {
  name               = "cloudx-alb"
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = [for subnet in aws_subnet.public : subnet.id]
}

resource "aws_lb_target_group" "ghost-ec2" {
  name     = "ghost-ec2"
  port     = 2368
  protocol = "HTTP"
  vpc_id   = aws_vpc.main.id
}

resource "aws_lb_target_group" "ghost-fargate" {
  target_type = "ip"
  name        = "ghost-fargate"
  port        = 2368
  protocol    = "HTTP"
  vpc_id      = aws_vpc.main.id
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.cloudx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
      target_group {
        arn    = aws_lb_target_group.ghost-ec2.arn
        weight = "50"
      }
      target_group {
        arn    = aws_lb_target_group.ghost-fargate.arn
        weight = "50"
      }
    }
  }
}
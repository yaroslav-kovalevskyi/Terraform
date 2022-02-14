resource "aws_launch_configuration" "cdp_lc" {
  name_prefix     = "Highly_Availability_LC-"
  image_id        = data.aws_ami.latest_amazon_linux
  instance_type   = var.instance_type
  security_groups = [aws_security_group.Nextcloud_Security_Group.id]
  #user_data       = file("nextcloud.sh")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "cdp-asg" {
  name_prefix          = "CDP_ASG_Using_${aws_launch_configuration.cdp_lc.name}"
  launch_configuration = aws_launch_configuration.cdp_lc.name
  min_size             = 1
  max_size             = 1
  min_elb_capacity     = 1
  health_check_type    = "ELB"
  vpc_zone_identifier  = [aws_subnet.public.id]
  load_balancers       = [aws_elb.cdp_elb.name]

  depends_on = [aws_db_instance.mySQL]

  tags = [
    {
      key                 = "Name"
      value               = "CDP_Nextcloud_in_ASG"
      propagate_at_launch = true
  }]
}

resource "aws_elb" "cdp_elb" {
  name            = "CDPHighlyAvailableELB"
  security_groups = [aws_security_group.Nextcloud_Security_Group.id]
  subnets         = [aws_subnet.public.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    interval            = 10
    target              = "HTTP:80/"
    timeout             = 3
    unhealthy_threshold = 2
  }

  tags = {
    Name = "CDP_Nextcloud_Highly_Available_ELB"
  }
}
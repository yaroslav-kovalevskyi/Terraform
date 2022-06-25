resource "aws_launch_template" "ghost-lt" {
  name                   = "ghost"
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = var.ec2_key_name
  user_data              = filebase64("ghost.sh")
  image_id               = data.aws_ami.latest_amazon_linux.image_id
  update_default_version = true
  iam_instance_profile {
    name = aws_iam_instance_profile.cloudx_instance_profile.name
  }
}

resource "aws_autoscaling_group" "ghost_ec2_pool" {
  name                = "${var.project}-ghost"
  vpc_zone_identifier = [for subnet in aws_subnet.public : subnet.id]
  max_size            = 1
  min_size            = 1
  target_group_arns   = [aws_lb_target_group.ghost-ec2.id]
  launch_template {
    id      = aws_launch_template.ghost-lt.id
    version = "$Latest"
  }
}

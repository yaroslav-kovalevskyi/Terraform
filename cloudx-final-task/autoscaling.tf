resource "aws_launch_template" "ghost-lt" {
  name                   = "ghost"
  instance_type          = var.ec2_instance_type
  vpc_security_group_ids = [aws_security_group.ec2.id]
  key_name               = var.ec2_key_name
  user_data              = filebase64("ghost.sh")
  image_id               = data.aws_ami.latest_amazon_linux.image_id
  update_default_version = true
  network_interfaces {
    subnet_id       = aws_subnet.public[0].id
    security_groups = [aws_security_group.ec2.id]
  }
  network_interfaces {
    subnet_id       = aws_subnet.public[1].id
    security_groups = [aws_security_group.ec2.id]
  }
  iam_instance_profile {
    name = aws_iam_instance_profile.cloudx_instance_profile.name
  }
}
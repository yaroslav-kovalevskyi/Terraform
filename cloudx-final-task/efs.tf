resource "aws_efs_file_system" "ghost_content" {
  creation_token = "ghost_content"

  tags = {
    Name = "ghost_content"
  }
}

resource "aws_efs_mount_target" "main" {
  count           = length(var.subnet_zones)
  file_system_id  = aws_efs_file_system.ghost_content.id
  subnet_id       = element(aws_subnet.public.*.id, count.index)
  security_groups = [aws_security_group.efs.id]
}
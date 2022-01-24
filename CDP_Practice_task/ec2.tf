resource "aws_instance" "nextcloud" {
  ami                    = "ami-0d527b8c289b4af7f"
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.aws_sg_nextcloud.id]
}


resource "aws_instance" "nextcloud_ubuntu" {
  ami                    = data.aws_ami.latest_ubuntu.id
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.Nextcloud_Security_Group.id]
  #user_data              = file("nextcloud.sh")                    #here should be nextcloud that will be run by docker
  depends_on = [aws_db_instance.mySQL]                                                  #depends on db instance
  private_ip = "10.0.0.12"
  subnet_id = aws_subnet.public.id

  tags = {
    Name = "[CDP] Nextcloud Ubuntu 20.04"
  }
}

#################### Instance ####################

resource "aws_instance" "ubuntu" {
  instance_type   = "t2.micro"
  ami             = data.aws_ami.ubuntu.id
  key_name        = aws_key_pair.generated.key_name
  subnet_id       = var.subnet_id
  security_groups = [aws_security_group.ec2.id, aws_security_group.alb.id]
  #user_data       = file("${path.module}/ubuntu_bootstrap.sh")

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

#################### Listeners ####################

#################### Target groups ####################




########################## EC2 ##########################

resource "aws_instance" "wordpress" {
  # required fields
  ami           = data.aws_ami.ubuntu24lts.image_id
  instance_type = var.ec2_variables.instance_type

  # optinal fields
  key_name  = aws_key_pair.wordpress_ec2.key_name
  subnet_id = var.ec2_variables.public_subnet_id
  # user_data              = file("${path.module}/wordpress_bootstrap.sh")
  vpc_security_group_ids = [aws_security_group.wordpress.id]

  tags = {
    Name = "${terraform.workspace} | ${var.project} wordpress Host instance"
  }
}

########################## Key Pair ##########################

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content              = tls_private_key.rsa.private_key_pem
  filename             = "../ssh/${terraform.workspace}_${lower(var.project)}_wordpress_ssh.pem"
  directory_permission = "0400"
  file_permission      = "0400"

  #   provisioner "local-exec" {
  #     command = "aws s3 sync ../ssh s3://${lower(var.project)}-ssh"
  #   }
}

resource "aws_key_pair" "wordpress_ec2" {
  key_name   = "${terraform.workspace}_${lower(var.project)}_wordpress_ssh"
  public_key = tls_private_key.rsa.public_key_openssh
}



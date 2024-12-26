########################## EC2 ##########################

resource "aws_instance" "wordpress" {
  # required fields
  ami           = data.aws_ami.ubuntu24lts.image_id
  instance_type = var.ec2_variables.instance_type

  # optinal fields
  key_name               = aws_key_pair.wordpress_ec2.key_name
  subnet_id              = var.ec2_variables.public_subnet_id
  vpc_security_group_ids = [aws_security_group.wordpress.id]
  user_data              = <<-EOF
    #!/bin/bash
    echo 'DB_NAME="${aws_db_instance.main.db_name}"' > /tmp/.wp_env
    echo 'DB_HOST="${aws_db_instance.main.address}"' >> /tmp/.wp_env
    echo 'DB_USER="${aws_db_instance.main.username}"' >> /tmp/.wp_env
    echo 'DB_PASSWORD="${random_password.master_password.result}"' >> /tmp/.wp_env
    echo 'WP_TITLE="${var.general.project} WordPress"' >> /tmp/.wp_env
    echo 'WP_ADMIN_USER="admin"' >> /tmp/.wp_env
    echo 'WP_ADMIN_PASSWORD="${strrev(random_password.master_password.result)}"' >> /tmp/.wp_env
    echo 'WP_ADMIN_EMAIL="${var.ec2_variables.wp_admin_email}"' >> /tmp/.wp_env
    echo 'WP_DIR="/var/www/html/wp/"' >> /tmp/.wp_env
    echo 'REDIS_ENDPOINT="${aws_elasticache_cluster.login_sessions.cache_nodes[0]["address"]}"' >> /tmp/.wp_env
    echo 'REDIS_PORT="${aws_elasticache_cluster.login_sessions.cache_nodes[0]["port"]}"' >> /tmp/.wp_env
  EOF 

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(local_file.tf-key.filename)
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    script = "../wp/wordpress_bootstrap.sh"
  }

  depends_on = [aws_elasticache_cluster.login_sessions]
  tags = {
    Name = "${terraform.workspace} | ${var.general.project} wordpress Host instance"
  }

}

########################## Key Pair ##########################

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "tf-key" {
  content              = tls_private_key.rsa.private_key_pem
  filename             = "../ssh/${terraform.workspace}_${lower(var.general.project)}_wordpress_ssh.pem"
  directory_permission = "0400"
  file_permission      = "0400"
}

resource "aws_key_pair" "wordpress_ec2" {
  key_name   = "${terraform.workspace}_${lower(var.general.project)}_wordpress_ssh"
  public_key = tls_private_key.rsa.public_key_openssh
}

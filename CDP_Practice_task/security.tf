resource "aws_security_group" "aws_sg_db" {
  name = "DataBase SG"
}

resource "aws_security_group" "aws_sg_nextcloud" {
  name = "Nextcloud SG"
}
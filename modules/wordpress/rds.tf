resource "aws_db_instance" "main" {
  # required fields
  allocated_storage = var.db_variables.storage
  engine            = var.db_variables.engine
  instance_class    = var.db_variables.instance_class
  password          = random_password.master_password.result
  username          = var.db_variables.master_username

  # optional fields

  #   backup_retention_period             = var.db_variables.brp
  #   backup_window                       = var.db_variables.backup_window
  #   copy_tags_to_snapshot               = var.db_variables.copy_tags
  db_name              = var.db_variables.db_name
  db_subnet_group_name = var.db_variables.subnet_group
  #   engine_version                      = var.db_variables.engine_version
  #   iam_database_authentication_enabled = var.db_variables.auth_enabled
  identifier = var.db_variables.identifier
  #   maintenance_window                  = var.db_variables.maintenance_window
  #   max_allocated_storage               = var.db_variables.storage_max
  publicly_accessible = var.db_variables.publicly_accessible
  #   port                                = var.db_variables.port
  #   skip_final_snapshot                 = true
  vpc_security_group_ids = [aws_security_group.database.id]

  tags = {
    Name = "${terraform.workspace}_${lower(var.project)}_db_instance"
  }

  lifecycle {
    prevent_destroy = false
  }
}

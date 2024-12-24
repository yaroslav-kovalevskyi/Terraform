######################### Password generation #########################

# This block randomly generates master password for database instance
resource "random_password" "master_password" {
  length           = 16
  special          = true
  override_special = "_!%^"
}

######################### Secrets creation #########################
# This block put the password to AWS Secrets Manager
resource "aws_secretsmanager_secret" "database" {
  name                    = "${terraform.workspace}_${lower(var.project)}_database_secrets"
  recovery_window_in_days = 10
}

resource "aws_secretsmanager_secret_version" "database" {
  secret_id = aws_secretsmanager_secret.database.id
  secret_string = jsonencode(
    {
      WORDPRESS_DB          = aws_db_instance.main.db_name
      WORDPRESS_DB_HOST     = aws_db_instance.main.address
      WORDPRESS_DB_PORT     = aws_db_instance.main.port
      WORDPRESS_DB_USER     = aws_db_instance.main.username
      WORDPRESS_DB_PASSWORD = random_password.master_password.result
    }
  )
}

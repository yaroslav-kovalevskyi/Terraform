resource "aws_elasticache_subnet_group" "redis" {
  name       = "${terraform.workspace}-${var.general.project}-cache-subnet-group"
  subnet_ids = var.private_subnets
}

resource "aws_elasticache_cluster" "login_sessions" {
  cluster_id           = var.redis_variables.cluster_id
  engine               = "redis"
  node_type            = var.redis_variables.node_type //"cache.m4.large"
  num_cache_nodes      = var.redis_variables.num_cache_nodes
  parameter_group_name = var.redis_variables.parameter_group_name //"default.redis3.2"
  engine_version       = var.redis_variables.engine_version       // "3.2.10"
  port                 = 6379
  security_group_ids   = [aws_security_group.wordpress.id]
  subnet_group_name    = aws_elasticache_subnet_group.redis.name //var.redis_variables.subnet_group_name
}

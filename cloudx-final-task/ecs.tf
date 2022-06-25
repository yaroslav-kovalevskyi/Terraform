resource "aws_ecs_cluster" "ghost" {
  name = "ghost-cluster"
}

resource "aws_ecr_repository" "private" {
  name = "${var.project}-private-repo"
}

resource "aws_ecs_task_definition" "ghost" {
  family                   = "ghost-app-task-definition"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 1024
  container_definitions    = file("ghost.json")
  task_role_arn            = aws_iam_role.ghost_app.arn
  execution_role_arn       = aws_iam_role.ghost_app.arn
  volume {
    name = "ghost-storage"
    efs_volume_configuration {
      file_system_id = aws_efs_file_system.ghost_content.id
    }
  }
}

resource "aws_ecs_service" "ghost-ecs" {
  name            = "ghost-ecs"
  cluster         = aws_ecs_cluster.ghost.id
  task_definition = aws_ecs_task_definition.ghost.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets         = [for subnet in aws_subnet.private : subnet.id]
    security_groups = [aws_security_group.fargate.id]
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.ghost-fargate.arn
    container_name   = "ghost"
    container_port   = 80
  }
}
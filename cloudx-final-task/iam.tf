resource "aws_iam_role_policy" "ghost_app" {
  name = "ghost_app_policy"
  role = aws_iam_role.ghost_app.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "kms:Decrypt",
          "ssm:GetParameterHistory",
          "ecr:GetDownloadUrlForLayer",
          "ecr:GetAuthorizationToken",
          "elasticfilesystem:ClientWrite",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "logs:PutLogEvents",
          "ec2:Describe*",
          "logs:CreateLogStream",
          "secretsmanager:GetSecretValue",
          "elasticfilesystem:ClientMount",
          "ecr:BatchGetImage",
          "ssm:GetParametersByPath",
          "elasticfilesystem:DescribeFileSystems",
          "ecr:BatchCheckLayerAvailability"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "ghost_app" {
  name = "ghost_app_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = ["ec2.amazonaws.com", "ecs-tasks.amazonaws.com"]
        }
      },
    ]
  })
}

resource "aws_iam_instance_profile" "cloudx_instance_profile" {
  name = "cloudx_instance_profile"
  role = aws_iam_role.ghost_app.name
  tags = {
    Name = "GhostApp Instance Profile"
  }
}

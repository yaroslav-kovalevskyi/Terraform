resource "aws_vpc_endpoint" "ecr" {
  for_each           = toset(var.vpc_endpoint)
  service_name       = "com.amazonaws.${var.region}.${each.value}"
  vpc_id             = aws_vpc.main.id
  vpc_endpoint_type  = "Interface"
  security_group_ids = [aws_security_group.vpc_endpoint.id]
  tags = {
    Name = each.value
  }
}

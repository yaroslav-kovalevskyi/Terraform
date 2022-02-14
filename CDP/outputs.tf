
output "CDP_loadbalancer_URL" {
  value = aws_elb.cdp_elb.dns_name
}
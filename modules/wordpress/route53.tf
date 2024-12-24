resource "aws_route53_record" "database" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = local.database_domain_formatted
  type    = "CNAME"
  ttl     = 86400
  records = [aws_db_instance.main.address]
}

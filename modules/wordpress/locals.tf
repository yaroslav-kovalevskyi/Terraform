locals {
  database_domain_formatted = "${var.project}.wordpressdb.${data.aws_route53_zone.selected.name}"
}

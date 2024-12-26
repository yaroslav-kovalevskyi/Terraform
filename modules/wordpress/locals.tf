locals {
  database_domain_formatted = "${var.general.project}.wordpressdb.${data.aws_route53_zone.selected.name}"
}

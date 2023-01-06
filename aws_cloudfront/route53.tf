resource "aws_route53_record" "sub_domain" {
  zone_id = data.aws_route53_zone.selected.zone_id
  name    = "${var.sub_domain}.${data.aws_route53_zone.selected.name}"
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.cf_from_tf.domain_name
    zone_id                = aws_cloudfront_distribution.cf_from_tf.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [
    aws_cloudfront_distribution.cf_from_tf
  ]
}

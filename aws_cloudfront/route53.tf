resource "aws_route53_record" "s3_cloudfront_records" {
  count   = length(local.all_s3_to_route)
  zone_id = data.aws_route53_zone.project_hosted_zone.id
  name    = element(local.all_s3_to_route, count.index)
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.s3_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.s3_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [
    aws_cloudfront_distribution.s3_cloudfront
  ]
}

resource "aws_route53_record" "lb_cloudfront_records" {
  count   = length(local.all_lb_to_route)
  zone_id = data.aws_route53_zone.project_hosted_zone.id
  name    = element(local.all_lb_to_route, count.index)
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.lb_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.lb_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [
    aws_cloudfront_distribution.lb_cloudfront
  ]
}

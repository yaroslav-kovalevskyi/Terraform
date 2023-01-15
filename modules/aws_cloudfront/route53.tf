resource "aws_route53_record" "cloudfront_records" {
  count   = length(local.all_domains)
  zone_id = data.aws_route53_zone.project_hosted_zone.id
  name    = element(local.all_domains, count.index)
  type    = "A"
  alias {
    name                   = aws_cloudfront_distribution.project_cloudfront.domain_name
    zone_id                = aws_cloudfront_distribution.project_cloudfront.hosted_zone_id
    evaluate_target_health = false
  }
  depends_on = [
    aws_cloudfront_distribution.project_cloudfront
  ]
}

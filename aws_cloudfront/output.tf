output "s3_cloudfront_aliases" {
  value = aws_cloudfront_distribution.s3_cloudfront.aliases
}

output "lb_cloudfront_aliases" {
  value = aws_cloudfront_distribution.lb_cloudfront.aliases
}
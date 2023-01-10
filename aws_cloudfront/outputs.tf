output "CloudFront_URL" {
  value = aws_cloudfront_distribution.cf_from_tf.aliases
}


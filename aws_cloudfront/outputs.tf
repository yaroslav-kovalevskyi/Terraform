output "CloudFront_URL" {
  value = aws_cloudfront_distribution.cf_from_tf.aliases
}

output "bucket_endpoint" {
  value = data.aws_s3_bucket.yk-cf-from-tf.website_endpoint
}

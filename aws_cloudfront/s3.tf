resource "aws_s3_bucket_policy" "closed_policy" {
  provider = aws.bucket_location
  bucket   = data.aws_s3_bucket.yk-cf-from-tf.id
  policy   = file("bucket_policy.json")


  depends_on = [
    aws_cloudfront_distribution.cf_from_tf,
    aws_route53_record.sub_domain
  ]
}

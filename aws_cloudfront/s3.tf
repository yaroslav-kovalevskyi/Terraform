resource "aws_s3_bucket_policy" "only_cloudfront_has_access" {
  bucket = data.aws_s3_bucket.bucket_for_cloudfront.id
  policy = data.aws_iam_policy_document.only_cloudfront_has_access.json

  depends_on = [
    aws_cloudfront_distribution.s3_cloudfront
  ]
}

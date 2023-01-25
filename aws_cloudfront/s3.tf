resource "aws_s3_bucket_policy" "only_cloudfront_has_access" {
  bucket = data.aws_s3_bucket.bucket_for_cloudfront.id
  policy = data.aws_iam_policy_document.only_cloudfront_has_access.json

  depends_on = [
    aws_cloudfront_distribution.project_cloudfront
  ]
}

resource "aws_s3_bucket" "bucket_for_lambda" {
  bucket = "${var.project_name}-lambdaedge"
}

resource "aws_s3_bucket_acl" "private" {
  bucket = aws_s3_bucket.bucket_for_lambda.id
  acl    = "private"
}

resource "aws_s3_object" "lambda_content_to_bucket" {
  bucket = aws_s3_bucket.bucket_for_lambda.id
  key    = "content.py.zip"
  source = "./lambdas/content.py.zip"
}

resource "aws_s3_object" "lambda_redirect_to_bucket" {
  bucket = aws_s3_bucket.bucket_for_lambda.id
  key    = "redirect.js.zip"
  source = "./lambdas/redirect.js.zip"
}

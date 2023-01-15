resource "aws_lambda_function" "content_handler" {
  function_name = "lambda-edge-content-handler"
  description   = "Lambda@Edge for Cloufront content handling"
  role          = aws_iam_role.for_lambda.arn
  runtime       = "python3.9"
  architectures = ["x86_64"]
  s3_bucket     = aws_s3_bucket.bucket_for_lambda.id
  s3_key        = aws_s3_object.lambda_to_bucket.id
  handler       = "lambda.lambda_handler"
  publish       = true
  timeout       = 15
}

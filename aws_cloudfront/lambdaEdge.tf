resource "aws_lambda_function" "content_handler" {
  function_name = "lambda-edge-content-handler"
  description   = "Lambda@Edge for Cloufront content handling"
  role          = aws_iam_role.for_lambda.arn
  runtime       = "python3.9"
  architectures = ["x86_64"]
  filename      = data.archive_file.content.output_path
  handler       = "content.handler"
  publish       = true
}

resource "aws_lambda_function" "redirect_handler" {
  function_name = "lambda-edge-redirect-handler"
  description   = "Lambda@Edge for Cloufront redirecting from www to non-www"
  role          = aws_iam_role.for_lambda.arn
  runtime       = "nodejs16.x"
  architectures = ["x86_64"]
  filename      = data.archive_file.redirect.output_path
  handler       = "redirect.handler"
  publish       = true
}

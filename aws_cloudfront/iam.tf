resource "aws_iam_role" "for_lambda" {
  name               = "lambdaEdge"
  assume_role_policy = data.aws_iam_policy_document.for_lambda.json
}

resource "aws_iam_role_policy_attachment" "extending_for_lambda" {
  role       = "lambdaEdge"
  policy_arn = data.aws_iam_policy.aws_managed_lambda.arn

  depends_on = [
    aws_iam_role.for_lambda
  ]
}

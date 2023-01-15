data "aws_s3_bucket" "bucket_for_cloudfront" {
  bucket = var.bucket_for_cloudfront
}

data "aws_route53_zone" "project_hosted_zone" {
  name         = var.project_domain_name
  private_zone = false
}

data "aws_iam_policy" "aws_managed_lambda" {
  name = "AWSLambdaBasicExecutionRole"
}

data "aws_acm_certificate" "amazon_issued" {
  domain      = var.project_domain_name
  most_recent = true
  # key_types = [] // RSA_1024 | RSA_2048 | RSA_3072 | RSA_4096 | EC_prime256v1 | EC_secp384r1 | EC_secp521r1
  # statuses = [] // PENDING_VALIDATION, ISSUED, INACTIVE, EXPIRED, VALIDATION_TIMED_OUT, REVOKED, FAILED
  # types = [] // AMAZON_ISSUED, PRIVATE, IMPORTED
}



// ----------------------------------------------------------------------
// -------------------------GENERATED-POLICIES---------------------------
// ----------------------------------------------------------------------

data "aws_iam_policy_document" "only_cloudfront_has_access" {
  statement {
    sid    = "AllowOnlyForCloudfront"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }
    actions = [
      "s3:GetObject"
    ]
    resources = [
      "${data.aws_s3_bucket.bucket_for_cloudfront.arn}/*"
    ]
    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [aws_cloudfront_distribution.project_cloudfront.arn]
    }
  }
}

data "aws_iam_policy_document" "for_lambda" {
  statement {
    sid    = "GenerateTrustRelationshipPolicyForLambdaEdge"
    effect = "Allow"
    principals {
      type = "Service"
      identifiers = [
        "edgelambda.amazonaws.com",
        "lambda.amazonaws.com"
      ]
    }
    actions = ["sts:AssumeRole"]
  }
}

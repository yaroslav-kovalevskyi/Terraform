data "aws_s3_bucket" "yk-cf-from-tf" {
  bucket   = var.bucket_for_cf
  provider = aws.bucket_location
}

data "aws_acm_certificate" "amazon_issued" {
  domain = format("*.%s", var.domain)
}

data "aws_route53_zone" "selected" {
  name         = var.domain
  private_zone = false
}


resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.project}-Origin-Access-Control"
  description                       = "Created with power of Terraform"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "cf_from_tf" {
  origin {
    domain_name              = data.aws_s3_bucket.yk-cf-from-tf.bucket_domain_name
    origin_id                = "${var.project}-Origin"
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  enabled             = true
  is_ipv6_enabled     = false
  comment             = "CDN from IaC"
  default_root_object = var.default_object

  aliases = [format("%s.%s", var.sub_domain, var.domain)]

  default_cache_behavior {
    allowed_methods  = var.allowed_methods
    cached_methods   = var.http_methods
    target_origin_id = "${var.project}-Origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
    viewer_protocol_policy = var.vpp
    min_ttl                = var.min_ttl
    default_ttl            = var.default_ttl
    max_ttl                = var.max_ttl
  }

  price_class = var.price_class

  restrictions {
    geo_restriction {
      restriction_type = var.restriction_type
      locations        = var.restricted_countries
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = data.aws_acm_certificate.amazon_issued.arn
    minimum_protocol_version       = "TLSv1.2_2019"
    ssl_support_method             = "sni-only"
  }
}

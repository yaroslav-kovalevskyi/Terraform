resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.project_name}-oac"
  description                       = "Origin Access Control created for ${var.project_name}"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_distribution" "project_cloudfront" {
  enabled         = true
  is_ipv6_enabled = false
  comment         = "${var.project_name} Cloudfront Distribution Config"
  aliases         = local.all_domains
  price_class     = "PriceClass_200"

  origin {
    origin_id                = local.full_origin_name
    domain_name              = local.full_origin_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
  }

  default_cache_behavior {
    target_origin_id       = local.full_origin_name
    allowed_methods        = var.allowed_methods
    cached_methods         = var.cached_methods
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = var.max_ttl / 2
    max_ttl                = var.max_ttl

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }

      headers = ["Host"]
    }

    lambda_function_association {
      event_type = "origin-request"
      lambda_arn = aws_lambda_function.content_handler.qualified_arn
    }
  }

  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }


  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = var.restricted_countries
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = false
    acm_certificate_arn            = data.aws_acm_certificate.amazon_issued.arn
    minimum_protocol_version       = "TLSv1.2_2019"
    ssl_support_method             = "sni-only"
  }

  depends_on = [
    aws_lambda_function.content_handler
  ]
}


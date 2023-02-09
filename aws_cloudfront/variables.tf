locals {
  bucket_name             = data.aws_s3_bucket.bucket_for_cloudfront.bucket
  bucket_region           = data.aws_s3_bucket.bucket_for_cloudfront.region
  full_s3_origin_name     = format("%s.s3.%s.amazonaws.com", local.bucket_name, local.bucket_region)
  fqdn                    = format("%s%s", "www.", var.major_project_domain_name) // fully qualified domain name
  formatted_major_domains = formatlist("%s.%s", concat(var.major_s3_sub_domains, var.major_lb_sub_domains), var.major_project_domain_name)
  formatted_minor_domains = (formatlist("%s.%s", concat(var.minor_s3_sub_domains, var.minor_lb_sub_domains), var.major_project_domain_name))
  all_s3_to_route         = concat(formatlist("%s.%s", var.major_s3_sub_domains, var.major_project_domain_name), formatlist("%s.%s", var.minor_s3_sub_domains, var.minor_project_domain_name), formatlist(local.fqdn), formatlist(var.major_project_domain_name))
  all_lb_to_route         = concat(formatlist("%s.%s", var.major_lb_sub_domains, var.major_project_domain_name), formatlist("%s.%s", var.minor_lb_sub_domains, var.minor_project_domain_name))
}

variable "environment" {}

variable "project_name" {}

variable "bucket_for_cloudfront" {
  description = "Bucket for Cloudfront origin source"
  default     = ""
}

variable "lb_name" {
  description = "LoadBalancer name for Cloudfront origin source"
}

variable "major_project_domain_name" {
  description = "Main project domain name"
}

variable "major_s3_sub_domains" {
  type        = list(any)
  description = "Sub domains which need to be mapped to main project domain name and point to static content from S3 bucket"
  default     = []
}

variable "major_lb_sub_domains" {
  type        = list(any)
  description = "Sub domains which need to be mapped to main project domain name and point to dynamic content from Load Balancer"
  default     = []
}

variable "minor_project_domain_name" {
  description = "Secondary project domain name"
  default     = ""
}

variable "minor_s3_sub_domains" {
  description = "Sub domains which need to be mapped to secondary project domain name and point to static content from S3 bucket"
  default     = []
}

variable "minor_lb_sub_domains" {
  description = "Sub domains which need to be mapped to secondary project domain name and point to dynamic content from Load Balancer"
  default     = []
}


variable "allowed_methods" {
  description = "List of allowed HTTP methods"
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  description = "Allowed caching methods"
  default     = ["GET", "HEAD"]
}

variable "max_ttl" {
  description = "Maximum Time to Live (in seconds). Default TTL counts according to maximum TTL"
  default     = 86400
}

variable "restricted_countries" {
  description = "Countries with restricted access (according to ISO 3166 alpha-2 country code list)"
  type        = list(any)
  default     = ["RU", "BY", "IR", "IQ"]
}

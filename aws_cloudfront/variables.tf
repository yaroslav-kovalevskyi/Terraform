locals {
  bucket_name       = data.aws_s3_bucket.bucket_for_cloudfront.bucket
  bucket_region     = data.aws_s3_bucket.bucket_for_cloudfront.region
  full_origin_name  = format("%s.s3.%s.amazonaws.com", local.bucket_name, local.bucket_region)
  formatted_domains = formatlist("%s.%s", var.sub_domains, var.project_domain_name)
  all_domains       = concat(local.formatted_domains, formatlist(var.project_domain_name))
}

variable "project_name" {
  default = "totem-test"
}

variable "project_domain_name" {
  default = "wouldyouliketo.click"
}

variable "sub_domains" {
  type        = list(any)
  description = "All sub domains which you want to use with Cloudfront"
  default     = ["main-cf", "sec-cf", "manual", "cf-from-tf"]
}

variable "bucket_for_cloudfront" {
  description = "Bucket for Cloudfront origin source"
  default     = "totem-bucket-for-cloudfront"
}

variable "lambda_function" {
  default = "lambdaEdge1"
}

variable "allowed_methods" {
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  default = ["GET", "HEAD"]
}

variable "max_ttl" {
  description = "Maximum Time to Live (in seconds). Default TTL counts according to maximum TTL"
  default     = 10800
}

variable "restricted_countries" {
  description = "Countries with restricted access (ISO 3166 alpha-2 country code list)"
  type        = list(any)
  default     = ["RU", "BY", "IR", "IQ"]
}

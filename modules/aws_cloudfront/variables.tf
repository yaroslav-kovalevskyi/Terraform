locals {
  bucket_name                 = data.aws_s3_bucket.bucket_for_cloudfront.bucket
  bucket_region               = data.aws_s3_bucket.bucket_for_cloudfront.region
  full_origin_name            = format("%s.s3.%s.amazonaws.com", local.bucket_name, local.bucket_region)
  fqdn                        = format("%s%s", "www.", var.project_domain_name) // fully qualified domain name
  formatted_domains           = formatlist("%s.%s", var.sub_domains, var.project_domain_name)
  # formatted_alternate_domains = (formatlist("%s.%s", var.sub_domains_for_alternate_domain, var.alternate_project_domain_name)) // ❗️
  all_domains                 = concat(formatlist(var.project_domain_name), formatlist(local.fqdn), local.formatted_domains) #, local.formatted_alternate_domains) // ❗️closing bracket need to be deleted as well
}

variable "environment" {}

variable "bucket_for_cloudfront" {
  description = "Bucket for Cloudfront origin source"
  default     = ""  
}

variable "project_domain_name" {}

variable "lb_name" {}

variable "project_name" {}

variable "project_domain_name" {}

variable "sub_domains" {
  type        = list(any)
  description = "All sub domains which you want to use with Cloudfront"
  default     = []
}

//❗️ Uncomment all blocks with exlamation mark  
//❗️ to switch on Cloudfront for different domain names.
//❗️ DO NOT FORGET CHECK .TFVARS FILE AS WELL
# variable "alternate_project_domain_name" {
#   description = "Use in case project has content for Cloudfront, associated with another domain name"
#   default     = ""
# }

# variable "sub_domains_for_alternate_domain" {
#   default = []
# }
// ------------------------------------------------------------


variable "allowed_methods" {
  default = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
}

variable "cached_methods" {
  default = ["GET", "HEAD"]
}

variable "max_ttl" {
  description = "Maximum Time to Live (in seconds). Default TTL counts according to maximum TTL"
  default     = 86400
}

variable "restricted_countries" {
  description = "Countries with restricted access (ISO 3166 alpha-2 country code list)"
  type        = list(any)
  default     = ["RU", "BY", "IR", "IQ"]
}

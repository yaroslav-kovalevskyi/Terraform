variable "project" {
  description = "The name of project"
  default     = "CloudfrontFromTerraform" 
}

variable "bucket_for_cf" {
  description = "The source of cloufront distribution origin"
  default     = "yk-cf-from-tf"
}

variable "default_object" {
  description = "Object to show by default"
  default     = "index.html"
}

variable "sub_domain" {
  description = "Alias to create in Route53 and associate it with with CloudFront"
  default     = "cf-from-tf"
}

variable "domain" {
  description = "Project domain name"
  default     = "wouldyouliketo.click"
}

variable "allowed_methods" {
  description = "List of allowed cache methods"
  default     = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
  type        = list(any)
}

variable "http_methods" {
  type        = list(any)
  description = "Controls whether CloudFront caches the response to requests using the specified HTTP methods"
  default     = ["GET", "HEAD"]
}

variable "vpp" {
  description = "Viewer Protocol Policy"
  default     = "redirect-to-https"
}

variable "min_ttl" {
  description = "Minimum Time to Live (in seconds)"
  default     = 0
}

variable "default_ttl" {
  description = "Default Time to Live (in seconds)"
  default     = 3600
}

variable "max_ttl" {
  description = "Maximum Time to Live (in seconds)"
  default     = 86400
}

variable "price_class" {
  description = "One of three classes to be selected"
  default     = "PriceClass_100"
}

variable "restriction_type" {
  description = "whitelist or blacklist to be selected"
  default     = "blacklist"
}

variable "restricted_countries" {
  description = "Countries with restricted access (ISO 3166 alpha-2 country code list)"
  type        = list(any)
  default     = ["RU", "BY", "IR"]
}

variable "cert_mpv" {
  default = "TLSv1.2_2019"
  description = "Certificate Minimum Protocol version"
}
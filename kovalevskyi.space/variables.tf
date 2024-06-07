######################### General #########################
variable "region" {
  description = "Region to deploy"
  type        = string
  default     = "eu-central-1"
}

variable "project" {
  description = "Name of Project"
  default     = "Pet"
}

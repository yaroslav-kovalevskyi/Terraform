
variable "environment" {
  description = "Working environment"
  type        = string
}

variable "project" {
  default = ""
}

# Block of variables to map with outputs values from another modules

variable "subnet_id" {
  default = ""
}

variable "security_groups" {
  default = []
}

variable "vpc_id" {
  default = ""
}

variable "subnets" {
  default = []
}

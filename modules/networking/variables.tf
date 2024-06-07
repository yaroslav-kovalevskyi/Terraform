######################### General #########################
variable "environment" {
  description = "Working environment"
}

variable "project" {
  description = "Name of Project"
}

######################### VPC #########################

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  default     = "10.0.0.0/16"
}


variable "public_subnet_cidr" {
  description = "CIDR blocks for Public subnets"
  default     = ["10.0.0.0/20", "10.0.16.0/20", "10.0.32.0/20"]
}

variable "private_subnet_cidr" {
  description = "CIDR blocks for Private subnets"
  default     = ["10.0.112.0/20", "10.0.128.0/20", "10.0.144.0/20"]
}

variable "database_subnet_cidr" {
  description = "CIDR blocks for Database subnets"
  default     = ["10.0.100.0/24", "10.0.200.0/24", "10.0.255.0/24"]
}

######################### NAT #########################

variable "nat_enabled" {
  description = "Toggler for NAT gateway"
  default     = false
}

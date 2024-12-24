variable "project" {
  description = "Name of Project"
  default     = ""
}

variable "domain_name" {
  description = "Project's domain name"
  default     = ""
}
########################## Database Variables ##########################

variable "db_variables" {
  description = "Declaring list of database variables"
  type        = map(string)
  default     = {}
}

########################## EC2 Variables ##########################

variable "ec2_variables" {
  description = "Declaring list of EC2 variables"
  type        = map(string)
  default     = {}
}

variable "external_vars" {
  description = "Declaring variable to get environment values from neighbor modules"
  type        = map(string)
  default     = {}
}

variable "vpc_id" {
  description = "Declare variable to be attached to VPC from another module"
  default     = ""
}

variable "wellknown_ip" {
  type        = map(string)
  description = "Well known CIDR blocks to access resources without any blockers"
  default     = {}
}



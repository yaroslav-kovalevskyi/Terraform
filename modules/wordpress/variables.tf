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
  description = "Map of database variables"
  type        = map(string)
  default     = {}
}

########################## EC2 Variables ##########################

variable "ec2_variables" {
  description = "Map of EC2 variables"
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


variable "service_ports" {
  type        = map(string)
  description = "List of service ports for WordPress Server"
  default     = {}
}

########################## Redis variables ##########################

variable "redis_variables" {
  description = "Map of Redis variables"
  type        = map(string)
  default     = {}
}

variable "private_subnets" {
  description = "List of Private Subnet IDs"
  default     = []
}

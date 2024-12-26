variable "general" {
  description = "Map of general variables"
  type        = map(string)
  default     = {}
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

variable "vpc_properties" {
  description = "Map of VPC properties"
  type        = map(string)
  default     = {}
}

variable "wellknown_ip" {
  type        = map(string)
  description = "Well known CIDR blocks to access resources without any blockers"
  default     = {}
}


variable "public_ports" {
  type        = map(string)
  description = "Map of public ports for WordPress Server"
  default = {
    http  = 80
    https = 443
  }
}

variable "internal_ports" {
  type        = map(string)
  description = "Map of internal / service ports for WordPress Server"
  default = {
    mysql = 3306
    redis = 6379
  }
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

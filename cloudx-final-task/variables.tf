/*--------------------
---------MAIN---------
--------------------*/

variable "project" {
  type        = string
  description = "name of the project"
  default     = "cloudx"
}

variable "region" {
  type        = string
  description = "default region to deploy the infrastructure"
  default     = "eu-central-1"
}

/*--------------------
------NETWORKING------
--------------------*/

variable "public_subnet_cidr" {
  type        = list(any)
  description = "List of subnets CIDRs"
  default     = ["10.10.1.0/24", "10.10.2.0/24", "10.10.3.0/24"]
}

variable "private_subnet_cidr" {
  type        = list(any)
  description = "List of subnets CIDRs"
  default     = ["10.10.10.0/24", "10.10.11.0/24", "10.10.12.0/24"]
}

variable "db_subnet_cidr" {
  type        = list(any)
  description = "List of subnets CIDRs"
  default     = ["10.10.20.0/24", "10.10.21.0/24", "10.10.22.0/24"]
}
#Attention: subnets availability zones are hardcoded and attached to the eu-central-1 region.
variable "subnet_zones" {
  type        = list(any)
  description = "List of subnets AZs"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

/*--------------------
-------DATABASE-------
--------------------*/

variable "db_name" {
  type        = string
  default     = "ghost"
  description = "Database's name"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Type and size of database instance"
}

variable "db_engine_version" {
  type        = string
  default     = "8.0"
  description = "Database's engine version"
}

/*--------------------
-------INSTANCE-------
--------------------*/

variable "ec2_instance_type" {
  type        = string
  description = "EC2 Instance Type"
  default     = "t2.micro"
}

variable "ec2_key_name" {
  type        = string
  description = "SSH key to connect to EC2s"
  default     = "ghost-ec2-pool"
}

/*--------------------
-------ENDPOINTS------
--------------------*/

variable "vpc_endpoint" {
  type        = list(any)
  description = "Desired services that needed access through endpoints"
  default     = ["ssm", "ecr.dkr", "elasticfilesystem", "s3", "monitoring", "logs"]
}
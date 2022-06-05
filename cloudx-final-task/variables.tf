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
  default     = "eu-south-1"
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
#Attention: subnets availability zones are hardcoded and attached to the eu-south-1 region.
variable "subnet_zones" {
  type        = list(any)
  description = "List of subnets AZs"
  default     = ["eu-south-1a", "eu-south-1b", "eu-south-1c"]
}
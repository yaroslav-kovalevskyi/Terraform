#________________________________________
#------------------MAIN-----------------|
#_______________________________________|
variable "region" {
  type        = string
  description = "AWS Region to Deploy"
  default     = "eu-north-1"
}

variable "project" {
  type    = string
  default = "CDP"
}
#______________________________________________
#---------------------ASG---------------------|
#_____________________________________________|
variable "instance_type" {
  type        = string
  description = "Instance Type"
  default     = "t3.micro"
}

#__________________________________________________
#------------------Security Group-----------------|
#_________________________________________________|
variable "allow_ports" {
  type        = list(any)
  description = "List of ports to open for server"
  default     = ["80", "443", "22", "8080"]
}


#___________________________________________
#------------------Database----------------|
#__________________________________________|
variable "db_name" {
  type        = string
  default     = ""
  description = "Database's name"
}

variable "db_username" {
  type        = string
  default     = ""
  description = "Database admin username"
}

variable "db_password" {
  type        = string
  default     = ""
  description = "Database password"
}

variable "db_instance_class" {
  type        = string
  default     = "db.t3.micro"
  description = "Type and size of database instance"
}
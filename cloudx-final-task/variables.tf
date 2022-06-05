/*--------------------
---------MAIN---------
--------------------*/

variable "project" {
  type        = string
  description = "name of the project"
  default     = "cloudx-yaroslav-k"
}

variable "region" {
  type        = string
  description = "default region to deploy the infrastructure"
  default     = "eu-south-1"
}


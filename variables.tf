variable "aws_region" {
  default = "ap-south-1"
}

variable "project_name" {
  default = "fms-app"
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "s3_bucket" {
  default = "prat-alb-asg"
}

variable "instance_type" {
  default = "t3.micro"
}

variable "rds_instance_type" {
  default = "db.t3.micro"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  description = "RDS password"
  default     = "Admin12345!"
  sensitive   = true
}

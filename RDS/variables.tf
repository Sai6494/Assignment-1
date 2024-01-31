variable "db_name" {
  type = string
  default = "Test-db"
}

variable "db_type" {
  type = string
  default = "db.t2.micro"
}

variable "db_engine" {
  type = string
  default = "postgres"
}

variable "vpc" {
  description = "VPC Id"
}

variable private_subnet {
  description = "private subnet for RDS"
  type = list(string)
}
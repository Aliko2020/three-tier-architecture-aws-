variable "db_username" {
  type = string
  default = "amos"
}

variable "db_password" {
  type = string
  description = "Db root user password"
  sensitive = true
}

variable "db_subnet_group_name" {
  type = string
  description = "Name of subnet of db"
}

variable "rds_security_group_ids" {
  type = list(string)
}


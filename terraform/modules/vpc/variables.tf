variable "cidr_block" {
  type        =   string
  description = "VPC CIDR_BLOCK"
  default     = "10.0.0.0/16"
}

variable "server_cidr_block" {
  type        = string
  description = "PUBLIC CIDR_BLOCK"
  default     = "10.0.1.0/24"
}

variable "rds_cidr_block" {
  type        = string
  description = "PRIVATE CIDR_BLOCK"
  default     = "10.0.2.0/24"
}

variable "rds_private_1" {
  type        = string
  description = "PRIVATE 1 CIDR_BLOCK"
  default     = "10.0.2.0/24"
}

variable "rds_private_2" {
  type        = string
  description = "PRIVATE 2 CIDR_BLOCK"
  default     = "10.0.3.0/24"
}
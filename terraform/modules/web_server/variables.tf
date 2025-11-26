variable "ami" {
  type     = string
  description = "ec2 instance ami"
  default = "ami-0fa3fe0fa7920f68e"
}

variable "instance_type" {
  type    = string
  description = "ec2 instance type"
  default = "t2.micro"
}

variable "key_name" {
  type  =  string
}

variable "subnet_id" {
  type  = string
}

variable "security_groups" {
  type  =  string
}
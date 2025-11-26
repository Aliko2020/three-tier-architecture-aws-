resource "aws_db_instance" "ecommerce" {
  identifier             = "ecommerce"
  instance_class         = "db.t3.micro"
  allocated_storage      = 5
  engine                 = "postgres"
  engine_version         = "14.12"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = var.db_subnet_group_name
  vpc_security_group_ids = var.rds_security_group_ids
  publicly_accessible    = false
  skip_final_snapshot    = true
  multi_az               = false
}

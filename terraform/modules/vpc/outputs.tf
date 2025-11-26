output "public_sn_id" {
  value = aws_subnet.server_sn.id
}

output "private_sn_ids" {
  value = [
    aws_subnet.rds_private_1.id,
    aws_subnet.rds_private_2.id
  ]
}

output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "rds_subnet_group_name" {
  value = aws_db_subnet_group.rds.name
}


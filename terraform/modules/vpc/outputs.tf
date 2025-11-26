output "public_sn_id" {
  value    = aws_subnet.server_sn.id
}

output "private_sn_id" {
  value    = aws_subnet.rds_sn.id
}

output "ec2_sg_id" {
  value    =  aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  value    =  aws_security_group.rds_sg.id
}
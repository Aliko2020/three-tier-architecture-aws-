resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name     = "ecommerce"
  }
}

resource "aws_internet_gateway" "main_gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main_gw"
  }
}

resource "aws_subnet" "server_sn" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.server_cidr_block

  tags = {
    Name     = "Main_public_sn"
  }
}

resource "aws_subnet" "rds_sn" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.rds_cidr_block

  tags = {
    Name     = "Main_private_sn"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id      = aws_vpc.main.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main_gw.id
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.server_sn.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table" "private_route_table" {
   vpc_id        = aws_vpc.main.id

   tags = {
    Name = "private_rt"
  }
}

resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.rds_sn.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_sg"
  description = "Allow HTTP/SSH"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "rds_sg"
  description = "Allow DB access from EC2"
  vpc_id      = aws_vpc.main.id

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.ec2_sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "web_server_instance" {
  ami           = var.ami
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  security_groups = [var.security_groups]
  associate_public_ip_address = true


  key_name      = var.key_name
  tags = {
    Name        = "WebServer"
    Environment = "Development"
  }
}
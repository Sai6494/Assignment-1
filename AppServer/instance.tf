resource "aws_instance" "AppServer" {
  ami                    = var.ami_type
  instance_type          = var.instance_type
  subnet_id              = var.private_subnets
  vpc_security_group_ids = [aws_security_group.AppServer_sg.id]
  depends_on             = [aws_security_group.AppServer_sg]
  tags = {
    Name = "AppServer"
  }
}

resource "aws_security_group" "AppServer_sg" {
  name        = "AppServer_sg"
  description = "Security group for AppServer"
  vpc_id      = var.vpc

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]                                 # Allow SSH access from anywhere for demonstration purposes
  }
  
  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "AppServer-security-group"
  }
}
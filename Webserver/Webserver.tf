resource "aws_eip" "Webserver_ip" {
  instance = aws_instance.Webserver.id
  tags = {
    Name = "Webserver-eip"
  }
  depends_on = [aws_instance.Webserver]
}

resource "aws_instance" "Webserver" {
  ami                    = var.ami_type
  instance_type          = var.instance_type
  subnet_id              = var.public_subnets
  vpc_security_group_ids = [aws_security_group.Webserver_sg.id]
  depends_on             = [aws_security_group.Webserver_sg]
  tags = {
    Name = "Webserver_Host"
  }
}

resource "aws_security_group" "Webserver_sg" {
  name        = "Webserver_sg"
  description = "Security group for Webserver host"
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
    Name = "Webserver-security-group"
  }
}
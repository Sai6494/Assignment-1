resource "aws_db_subnet_group" "main" {
  name       = "test-db-subnet-group"
  subnet_ids = var.private_subnet
  tags = {
    Name = "test_db_subnets"
  }
}

resource "aws_db_instance" "Test" {
 # identifier           = "postgresql-db-instance"
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = var.db_engine
  engine_version       = "11"
  instance_class       = var.db_type
 # name                 = var.db_name
  username             = "Test"
  password             = "Test12345"
  db_subnet_group_name = aws_db_subnet_group.main.name
  skip_final_snapshot = false
  final_snapshot_identifier = "db-snap"
}

resource "aws_security_group" "rds" {
  vpc_id = var.vpc

  ingress {
    from_port = 5432
    to_port   = 5432
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
    Name = "DBserver-security-group"
  }
}
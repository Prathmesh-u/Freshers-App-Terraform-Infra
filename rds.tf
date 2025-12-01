resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-subnet-group"
  subnet_ids = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]

  tags = { Name = "rds-subnet-group" }
}

resource "aws_db_instance" "mysql" {
  identifier              = "fms-rds"
  allocated_storage       = 20
  storage_type            = "gp3"
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = var.rds_instance_type

  db_name                 = "fmsdb"
  username                = var.db_username
  password                = var.db_password

  publicly_accessible     = true
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name

  skip_final_snapshot = true

  tags = { Name = "fms-rds" }
}

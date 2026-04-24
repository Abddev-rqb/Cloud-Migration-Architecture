# ----------------------------
# Subnet Group (required for RDS)
# ----------------------------
resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "rds-subnet-group"

  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "rds-subnet-group"
  }
}

# ----------------------------
# RDS MySQL Instance
# ----------------------------
resource "aws_db_instance" "mysql" {
  identifier = "migration-rds"

  engine         = "mysql"
  engine_version = "5.7"

  instance_class = "db.t3.micro"

  allocated_storage = 20

  db_name  = "testdb"
  username = "admin"
  password = "Admin1234!"

  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [var.rds_sg_id]

  publicly_accessible = false
  skip_final_snapshot = true

  multi_az = false

  tags = {
    Name = "migration-rds"
  }
}
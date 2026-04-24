resource "aws_dms_replication_subnet_group" "dms_subnet" {
  replication_subnet_group_id = "dms-subnet-group"
    replication_subnet_group_description = "DMS Subnet Group"

  subnet_ids = var.subnet_ids

  tags = {
    Name = "dms-subnet-group"
  }
}

resource "aws_dms_replication_instance" "dms_instance" {
  replication_instance_id = "dms-instance"

  replication_instance_class = "dms.t3.small"

  allocated_storage = 20

  vpc_security_group_ids = [var.dms_sg_id]
  replication_subnet_group_id = aws_dms_replication_subnet_group.dms_subnet.id

  publicly_accessible = false

  tags = {
    Name = "dms-instance"
  }
}

resource "aws_dms_endpoint" "source" {
  endpoint_id   = "source-endpoint"
  endpoint_type = "source"
  engine_name   = "mysql"

  username = "root"
  password = "rootpass"
  server_name = var.source_db_ip
  port = 3306

  database_name = "testdb"
}

resource "aws_dms_endpoint" "target" {
  endpoint_id   = "target-endpoint"
  endpoint_type = "target"
  engine_name   = "mysql"

  username = "admin"
  password = "Admin1234!"
  server_name = var.rds_endpoint
  port = 3306

  database_name = "testdb"
}

resource "aws_dms_replication_task" "migration" {
  replication_task_id          = "migration-task"
  migration_type               = "full-load-and-cdc"

  replication_instance_arn = aws_dms_replication_instance.dms_instance.replication_instance_arn
  source_endpoint_arn      = aws_dms_endpoint.source.endpoint_arn
  target_endpoint_arn      = aws_dms_endpoint.target.endpoint_arn

  table_mappings = jsonencode({
    rules = [
      {
        rule-type = "selection"
        rule-id   = "1"
        rule-name = "1"
        object-locator = {
          schema-name = "%"
          table-name  = "%"
        }
        rule-action = "include"
      }
    ]
  })
}

# ----------------------------
# IAM Role for DMS VPC Access
# ----------------------------
resource "aws_iam_role" "dms_vpc_role" {
  name = "dms-vpc-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "dms.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "dms_vpc_role_attach" {
  role       = aws_iam_role.dms_vpc_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonDMSVPCManagementRole"
}
# ----------------------------
# Get latest Amazon Linux 2 AMI
# ----------------------------
data "aws_ami" "amazon_linux" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# ----------------------------
# USER DATA (MySQL setup)
# ----------------------------
locals {
  mysql_user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              systemctl start docker
              systemctl enable docker

              docker run -d \
                --name mysql \
                -e MYSQL_ROOT_PASSWORD=rootpass \
                -e MYSQL_DATABASE=testdb \
                -p 3306:3306 \
                mysql:5.7
            EOF
}

# ----------------------------
# APP EC2 (Rehost)
# ----------------------------
resource "aws_instance" "app_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  associate_public_ip_address = true

  tags = {
    Name = "app-ec2"
  }
}

# ----------------------------
# ON-PREM SIMULATION EC2
# ----------------------------
resource "aws_instance" "onprem_ec2" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name               = var.key_name

  associate_public_ip_address = true

  user_data = local.mysql_user_data

  tags = {
    Name = "onprem-ec2"
  }
}
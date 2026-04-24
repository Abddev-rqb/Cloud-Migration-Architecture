output "ec2_sg_id" {
  value = aws_security_group.ec2_sg.id
}

output "rds_sg_id" {
  value = aws_security_group.rds_sg.id
}

output "dms_sg_id" {
  value = aws_security_group.dms_sg.id
}
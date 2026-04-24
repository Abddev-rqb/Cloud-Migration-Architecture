output "app_ec2_id" {
  value = aws_instance.app_ec2.id
}

output "onprem_ec2_id" {
  value = aws_instance.onprem_ec2.id
}

output "onprem_private_ip" {
  value = aws_instance.onprem_ec2.private_ip
}

output "app_public_ip" {
  value = aws_instance.app_ec2.public_ip
}

output "onprem_public_ip" {
  value = aws_instance.onprem_ec2.public_ip
}
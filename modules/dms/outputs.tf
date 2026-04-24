output "dms_instance_arn" {
  value = aws_dms_replication_instance.dms_instance.replication_instance_arn
}

output "dms_task_arn" {
  value = aws_dms_replication_task.migration.replication_task_arn
}

output "source_endpoint_arn" {
  value = aws_dms_endpoint.source.endpoint_arn
}

output "target_endpoint_arn" {
  value = aws_dms_endpoint.target.endpoint_arn
}
data "aws_caller_identity" "current" {}

locals {
  bucket_arn = "arn:aws:s3:::${var.bucket_name}"
}

resource "aws_cloudtrail" "main" {
  name                          = "cloud-migration-trail"
  s3_bucket_name                = var.bucket_name
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_logging                = true

  depends_on = [aws_s3_bucket_policy.cloudtrail_policy]

  tags = {
    Name = "cloudtrail"
  }
}

resource "aws_cloudwatch_log_group" "migration_logs" {
  name              = "/cloud-migration/logs"
  retention_in_days = 7
}

resource "aws_s3_bucket_policy" "cloudtrail_policy" {
  bucket = var.bucket_name

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid = "AWSCloudTrailAclCheck"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action   = [
          "s3:GetBucketAcl", "s3:GetBucketLocation"
          ]
        Resource = local.bucket_arn
      },
      {
        Sid = "AWSCloudTrailWrite"
        Effect = "Allow"
        Principal = {
          Service = "cloudtrail.amazonaws.com"
        }
        Action = "s3:PutObject"
        Resource = "${local.bucket_arn}/AWSLogs/${data.aws_caller_identity.current.account_id}/*"
        Condition = {
          StringEquals = {
            "s3:x-amz-acl" = "bucket-owner-full-control"
          }
        }
      }
    ]
  })
}
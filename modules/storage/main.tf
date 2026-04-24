resource "random_id" "suffix" {
  byte_length = 4
}

resource "aws_s3_bucket" "logs_bucket" {
  bucket = "cloud-migration-logs-${random_id.suffix.hex}"

  tags = {
    Name = "central-logs"
  }
}
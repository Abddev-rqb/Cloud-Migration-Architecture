variable "subnet_ids" {
  type = list(string)
}

variable "dms_sg_id" {
  type = string
}

variable "source_db_ip" {
  type = string
}

variable "rds_endpoint" {
  type = string
}
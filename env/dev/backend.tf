terraform {
  backend "s3" {
    bucket         = "cloud-migration-tf-state-13-206-108-124"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    use_lockfile   = true
  }
}
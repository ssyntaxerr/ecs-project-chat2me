terraform {
  backend "s3" {
    bucket = "c2m-terraform-state"
    key = "terraform.tfstate"
    region = "eu-north-1"
    use_lockfile = true
  }
}
terraform {
  backend "s3" {
    bucket = "c2mapp-terraform-state"
    key = "terraform.tfstate"
    region = "eu-north-1"
    use_lockfile = true
  }
}
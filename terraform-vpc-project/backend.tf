terraform {
  backend "s3" {
    bucket         = "terraform-vpc-backend"
    key            = "terraform.tfstate"
    region         = "us-east-1"
  }
}
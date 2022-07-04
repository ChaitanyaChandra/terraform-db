data "aws_ami" "ami" {
  most_recent = true
  name_regex  = "base-with-ansible"
  owners      = ["self"]
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraform-nonprod-state-chaitu-env"
    key    = "state/${var.ENV}/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "spot" {
  backend = "s3"
  config = {
    bucket = "terraform-nonprod-state-chaitu"
    key    = "terraform_ec2_spot.tfstate"
    region = "us-east-1"
  }
}
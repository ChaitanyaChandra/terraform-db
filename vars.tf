locals {
  env         = var.ENV
  Environment = local.env == "dr" || local.env == "prod" ? "prod" : "nonpord"
  region      = local.env == "dr" || local.env == "prod" ? "us-west-2" : "us-east-1"
  tags = {
    "Environment"  = local.Environment
    "region"       = local.region
    "Service"      = "chaitu"
    "SupportGroup" = "Managed Services L2"
  }
}

variable "ENV" {}
variable "MONGODB_INSTANCE_TYPE" {}

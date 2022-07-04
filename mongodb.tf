module "mongodb" {
  source                 = "./module/ec2"
  ENV                    = var.ENV
  AMI                    = data.aws_ami.ami.id
  INSTANCE_TYPE          = var.MONGODB_INSTANCE_TYPE
  SUBNET_ID              = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNETS[0]
  VPC_ID                 = data.terraform_remote_state.vpc.outputs.VPC_ID
  PRIVATE_SUBNET_CIDR    = data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_CIDR
  ALL_SUBNET_CIDR        = concat(data.terraform_remote_state.vpc.outputs.PRIVATE_SUBNET_CIDR, tolist([data.terraform_remote_state.vpc.outputs.vpc_cidr]))
  DB_COMPONENT           = "mongodb"
  DB_PORT                = 27017
  PRIVATE_HOSTED_ZONE_ID = data.terraform_remote_state.vpc.outputs.PRIVATE_HOSTED_ZONE_ID
  ec2_spot_fleet_role    = data.terraform_remote_state.spot.outputs.spot_role_id
  local_tags             = local.tags
}
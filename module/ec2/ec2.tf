resource "aws_spot_instance_request" "db" {
  ami                    = var.AMI
  instance_type          = var.INSTANCE_TYPE
  key_name               = "aws_key"
  subnet_id              = var.SUBNET_ID
  wait_for_fulfillment   = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  tags = {
    Name = "${var.DB_COMPONENT}-${var.ENV}"
  }
}

resource "aws_spot_fleet_request" "db" {
  iam_fleet_role  = var.ec2_spot_fleet_role
  target_capacity = 1
  launch_specification {
    instance_type          = var.INSTANCE_TYPE
    ami                    = var.AMI
    key_name               = "aws_key"
    subnet_id              = var.SUBNET_ID
    vpc_security_group_ids = [aws_security_group.sg.id]
    # ebs_optimized          = true
    root_block_device {
      volume_size = "10"
      volume_type = "gp2"
    }
    tags = merge(tomap({
      "Name" = "${var.DB_COMPONENT}-${var.ENV}"
    }), var.local_tags)
  }
  wait_for_fulfillment = true
  tags                 = var.local_tags
}

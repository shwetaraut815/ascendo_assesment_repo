
resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-south-1.ssm"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
  private_dns_enabled = true
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-south-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
  private_dns_enabled = true
}


resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = module.vpc.vpc_id
  service_name        = "com.amazonaws.ap-south-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = module.vpc.private_subnets
  security_group_ids = [aws_security_group.ssm_endpoint_sg.id]
  private_dns_enabled = true
}


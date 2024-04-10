module "vpc_example_complete" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.1"

  name = "MetNet"
  cidr = var.CIDR
  azs = [var.ZONE1, var.ZONE2, var.ZONE3]
  private_subnets = [var.PRIVSUB1, var.PRIVSUB2, var.PRIVSUB3]
  public_subnets = [var.PUBSUB1, var.PUBSUB2, var.PUBSUB3]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    Terraform = "true"
    environment = "Prod"

  }

  vpc_tags = {
    Name = "MetNet"
  }
}
module "vpc" {
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

resource "aws_security_group" "beanstalk_elb_sg" {
  vpc_id      = module.vpc.vpc_id
  name        = "beanstalk_elb_sg"
  description = "Security Group for Beanstalk load balancer"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Bastion_host_sg" {
  name        = "Bastion_host_sg"
  vpc_id      = module.vpc.vpc_id
  description = "Security Group for Bastion Host"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.MYIP]
  }
}

resource "aws_security_group" "beanstalk_instance_sg" {
  name        = "beanstalk_instance_sg"
  vpc_id      = module.vpc.vpc_id
  description = "Security Group for Instances under Beanstlak"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.Bastion_host_sg.id]
  }
}

resource "aws_security_group" "backend_services_sg" {
  name        = "backend_services_sg"
  vpc_id      = module.vpc.vpc_id
  description = "Secuirty group for backend Services"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.beanstalk_instance_sg.id]
  }

  ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    security_groups = [ aws_security_group.Bastion_host_sg.id ]
  }
}

resource "aws_security_group_rule" "Secuirty_group_rule" {
  type                     = "ingress"
  from_port                = 0
  to_port                  = 65535
  protocol                 = "tcp"
  security_group_id        = aws_security_group.backend_services_sg.id
  source_security_group_id = aws_security_group.backend_services_sg.id
  depends_on = [ aws_security_group.backend_services_sg ]
}
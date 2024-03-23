resource "aws_security_group" "first_terra_secgrp" {
  vpc_id      = aws_vpc.Terra_first_vpc.id
  name        = "First_terra_Stack_Security_group"
  description = "First_terra_Stack_Security_group"

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description = "Allow all traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Terra_sec_grp"
  }
}
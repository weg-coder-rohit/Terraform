resource "aws_key_pair" "vpc_new_key" {
  key_name   = "vpc_key"
  public_key = file(var.PUB_KEY)
}

resource "aws_instance" "terra_first_instance" {
  ami                    = var.AMIS["Nexus_server"]
  instance_type          = "t2.medium"
  subnet_id              = aws_subnet.PUBSUB1.id
  key_name               = aws_key_pair.vpc_new_key.key_name
  vpc_security_group_ids = [aws_security_group.first_terra_secgrp.id]
  user_data              = file("./userdata/nexus-setup.sh")

  tags = {
    Name = "Terra_first_instance"
  }
}

# resource "aws_ebs_volume" "terra_new_ebs" {
#   availability_zone = var.ZONE1
#   size              = 3
#   tags = {
#     Name = "Terra_New_ebs_volume"
#   }
# }

# resource "aws_volume_attachment" "new_volume_attach" {
#   device_name = "/dev/xvdh"
#   volume_id   = aws_ebs_volume.terra_new_ebs.id
#   instance_id = aws_instance.terra_first_instance.id
# }

output "PublicIP" {
  value = aws_instance.terra_first_instance.public_ip

}
resource "aws_instance" "Docker" {
  instance_type          = "t2.large"
  key_name               = "Docker-Key"
  ami = var.AMIS["Nexus_server"]
  vpc_security_group_ids = ["sg-056d9e172b30759c5"]
  user_data              = file("../../userdata/docker-setup.sh")

  tags = {
    Name = "Docker-Server"
  }
}


output "PublicIP" {
  value = aws_instance.Docker.public_ip
}

output "PrivateIP" {
  value = aws_instance.Docker.private_ip
}
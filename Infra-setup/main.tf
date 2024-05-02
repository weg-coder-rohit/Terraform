# module "vnet" {
#   source = "./module/vnet"
# }

# module "instances" {
#   source = "./module/instances"
# }

# module "SONAR-SERVER" {
#   source = "./module/SONAR-SERVER"
# }

# module "DOCKER-SERVER" {
#   source = "./module/DOCKER-SERVER"
# }

# module "Jenkins-Server" {
#   source = "./module/Jenkins-Server"
# }

# provider "aws" {
#   region = "us-west-2"  # Replace with your desired AWS region
# }

# resource "aws_instance" "ec2_instances" {
#   count = length(var.instance_types)

#   ami           = "ami-12345678"  # Replace with your desired AMI ID
#   instance_type = var.instance_types[count.index]
#   key_name      = "your-key-pair"  # Replace with your key pair name
#   security_groups = ["your-security-group-name"]  # Replace with your security group name
#   subnet_id     = "your-subnet-id"  # Replace with your subnet ID
# }

# variable "instance_types" {
#   type    = list(string)
#   default = ["t2.micro", "t3.medium", "m5.large"]
# }

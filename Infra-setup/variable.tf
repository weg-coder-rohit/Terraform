variable "REGION" {
  default = "us-east-2"
}

variable "AMIS" {
  type = map(any)
  default = {
    Nexus_server = "ami-01387af90a62e3c01"
    Sonar_server = "ami-007020fd9c84e18c7"
  }
}

variable "ZONE1" {
  default = "us-east-2a"
}

variable "ZONE2" {
  default = "us-east-2b"
}

variable "ZONE3" {
  default = "us-east-2c"
}

variable "CIDR" {
  default = "10.0.0.0/16"
}

variable "PUBSUB1" {
  default = "10.0.1.0/24"
}
variable "PUBSUB2" {
  default = "10.0.2.0/24"
}

variable "PUBSUB3" {
  default = "10.0.3.0/24"
}

variable "PRIVSUB1" {
  default = "10.0.4.0/24"
}

variable "PRIVSUB2" {
  default = "10.0.5.0/24"
}

variable "PRIVSUB3" {
  default = "10.0.6.0/24"
}

variable "USER" {
  default = "ec2-user"
}

variable "PUB_KEY" {
  default = "vpc_key.pub"
}

variable "PRIV_key" {
  default = "vpc_key"
}

variable "MYIP" {
  default = "110.235.216.56/32"
}
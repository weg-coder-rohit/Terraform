variable "AMIS" {
  type = map(any)
  default = {
    Nexus_server = "ami-01387af90a62e3c01"
    Sonar_server = "ami-007020fd9c84e18c7"
    Docker_server_ami = "ami-0b8b44ec9a8f90422"
  }
}

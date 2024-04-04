resource "aws_instance" "SONAR-SERVER" {
  ami =   "ami-007020fd9c84e18c7"
  instance_type          = "t2.medium"
  key_name               = "Jenkins-key"
  vpc_security_group_ids = ["sg-0fd8e20b68b9aae45"]
  user_data              = file("../userdata/sonar-setup.sh")

  tags = {
    Name = "SONAR-SETUP"
  }
}

terraform {
  required_providers {
    sonarqube = {
      source = "jdamata/sonarqube"
    }
  }
}

provider "sonarqube" {
    user   = "admin"
    pass   = "test1234" 
    host   = "http://15.206.164.40"
    
}

resource "sonarqube_qualitygate" "vprofileQG" {
  name        = "vprofileQG"

  condition {
    metric          = "bugs"
    op        = "GT"
    threshold = 25

  }
  depends_on = [ aws_instance.SONAR-SERVER ]
}
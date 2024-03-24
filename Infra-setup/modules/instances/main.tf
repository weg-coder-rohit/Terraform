# Nexus Server 

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

terraform {
  required_providers {
    nexus = {
      source  = "datadrivers/nexus"
      version = "2.2.0"
    }
  }
}

provider "nexus" {
  insecure = true
  password = "test1234"
  url      = "http://18.119.164.161:8081"
  username = "admin"
}

resource "nexus_repository_maven_hosted" "releases" {
  name   = "VprofileApp-releases"
  online = true

  storage {
    blob_store_name                = "default"
    strict_content_type_validation = false
    write_policy                   = "ALLOW"
  }

  maven {
    version_policy      = "RELEASE"
    layout_policy       = "STRICT"
    content_disposition = "INLINE"
  }
}

resource "nexus_repository_maven_proxy" "maven_central" {
  name   = "VprofileApp-central-repo1"
  online = true

  storage {
    blob_store_name                = "default"
    strict_content_type_validation = true
  }

  proxy {
    remote_url       = "https://repo1.maven.org/maven2/"
    content_max_age  = 1440
    metadata_max_age = 1440
  }

  negative_cache {
    enabled = true
    ttl     = 1440
  }

  http_client {
    blocked    = false
    auto_block = true
  }

  maven {
    version_policy = "RELEASE"
    layout_policy  = "STRICT"
  }
}

resource "nexus_repository_maven_hosted" "releases1" {
  name   = "VprofileApp-Snapshot"
  online = true

  storage {
    blob_store_name                = "default"
    strict_content_type_validation = false
    write_policy                   = "ALLOW"
  }

  maven {
    version_policy      = "SNAPSHOT"
    layout_policy       = "STRICT"
    content_disposition = "INLINE"
  }
}

resource "nexus_repository_maven_group" "group" {
  name   = "VprofileApp-group"
  online = true

  group {
    member_names = [
      nexus_repository_maven_hosted.releases.name,
      nexus_repository_maven_hosted.releases1.name,
      nexus_repository_maven_proxy.maven_central.name
    ]
  }

  storage {
    blob_store_name                = "default"
    strict_content_type_validation = true
  }
}

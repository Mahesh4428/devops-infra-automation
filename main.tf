#-------------#
# AWS Provider
#-------------#
provider "aws" {
  region = "ap-south-1"
}

#------------------------#
# EC2 Instances - Jenkins & K8s
#------------------------#
resource "aws_instance" "ansible_nodes" {
  count         = var.servercount
  ami           = var.amiid
  instance_type = var.type
  key_name      = var.pemfile
  associate_public_ip_address = true

  tags = {
    Name = element(["Jenkins", "K8s"], count.index)
  }

  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install -y python3
              EOF
}

#----------------------------#
# Generate Ansible Inventory
#----------------------------#
resource "local_file" "ansible_inventory" {
  content = templatefile("./templates/hosts.tpl", {
    keyfile      = var.pemfile,
    servers      = aws_instance.ansible_nodes[*].public_ip,
    names        = [for instance in aws_instance.ansible_nodes : instance.tags.Name]
  })
  filename = "./ansible/hosts.cfg"
}


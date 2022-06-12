provider "aws" {
  region = "eu-central-1"
}

# EC2

resource "aws_instance" "ec2_web" {
  ami                    = data.aws_ami.ami_debian.id
  instance_type          = var.instance_type
  key_name               = var.private_key
  vpc_security_group_ids = [aws_security_group.sg_web.id]
  tags                   = var.web_tags
}

# AMI

data "aws_ami" "ami_debian" {
  most_recent = true
  owners      = ["136693071363"]

  filter {
    name   = "name"
    values = ["debian-11-amd64-*"]
  }
}

#VPC

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "sg_web" {
  name        = "sg_web"
  description = "Allow http(s) and SSH"
  vpc_id      = data.aws_vpc.default.id

  dynamic "ingress" {
    for_each = ["80", "443"]
    content {
      description = "http/https tcp"
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = [var.public_cidr]
    }
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.personal_ip}/32"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

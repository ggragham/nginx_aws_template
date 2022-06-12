variable "instance_type" {
  default = "t2.micro"
}

variable "public_cidr" {
  default = "0.0.0.0/0"
}

variable "personal_ip" {
  type        = string
  description = "Enter your ip here ($ curl ident.me)"
}

variable "private_key" {
  default = "aws"
}

variable "web_tags" {
  default = {
    Name = "Nginx Web Server"
  }
}

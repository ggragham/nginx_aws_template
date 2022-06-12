output "ec2_web_id" {
  value = aws_instance.ec2_web.id
}

output "ec2_web_public_ip" {
  value = aws_instance.ec2_web.public_ip
}

output "ec2_web_public_dns" {
  value = aws_instance.ec2_web.public_dns
}

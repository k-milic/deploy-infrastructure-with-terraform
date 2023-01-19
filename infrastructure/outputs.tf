# This will output the DNS name after the resource has been created
output "aws_alb_public_dns" {
  value = aws_lb.nginx.dns_name
}

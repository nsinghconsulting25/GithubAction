output "alb_dns" {
  value = aws_lb.alb.dns_name
}

output "ecr_url" {
  value = aws_ecr_repository.app.repository_url
}
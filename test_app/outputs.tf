output "image_tag" {
  value = aws_subnet.uit.tags.image_tag
}
output "chart_version" {
  value = aws_subnet.uit.tags.chart_version
}

output "subnet_id" {
  value = aws_subnet.uit.id
}

# Application's outputs
output "chart_version" {
  value = var.chart_version
}

output "image_tag" {
  value = var.image_tag
}

output "proxy_endpoint" {
  value = data.aws_ecr_authorization_token.token.proxy_endpoint
}
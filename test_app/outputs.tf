output "image_tag" {
  value = aws_subnet.uit.tags.image_tag
}
output "chart_version" {
  value = aws_subnet.uit.tags.chart_version
}

output "subnet_id" {
  value = aws_subnet.uit.id
}

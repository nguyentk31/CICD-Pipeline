output "vpc_id" {
  value = aws_vpc.uit.id
}

output "vpc_cidr" {
  value = aws_vpc.uit.cidr_block
}

output "vpc_name" {
  value = aws_vpc.uit.tags.Name
}
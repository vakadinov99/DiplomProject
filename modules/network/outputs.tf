output "subnet_ids_public" {
  value = aws_subnet.public.*.id
}

output "subnet_ids_private" {
  value = aws_subnet.private.*.id
}

output "subnet_cidrs_public" {
  value = aws_subnet.public.*.cidr_block
}

output "subnet_cidrs_private" {
  value = aws_subnet.private.*.cidr_block
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

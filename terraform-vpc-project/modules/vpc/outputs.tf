output "vpcs" {
  description = "VPC Outputs"
  value       = { for vpc in aws_vpc.this : vpc.tags.Name => { "cidr_block" : vpc.cidr_block, "id" : vpc.id } }
}

output "subnets" {
  description = "subnet id"
  value       = { for subnet in aws_subnet.this : subnet.tags.Name => { "arn" : subnet.arn, "id" : subnet.id } }
}

output "igw" {
  description = "igw"
  value       = { for igw in aws_internet_gateway.this : igw.tags.Name => { "arn" : igw.arn, "state" : igw.arn } }
}
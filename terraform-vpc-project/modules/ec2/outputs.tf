output "ec2" {
  description = "ec2 Outputs"
  value       = { for ec2 in aws_instance.this : ec2.tags.Name => { "public_ip" : ec2.public_ip} }
}
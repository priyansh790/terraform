output "sg" {
  description = "security group"
  value       = { for sg in aws_security_group.this : sg.tags.Name => { "id" = sg.id } }
}
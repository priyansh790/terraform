resource "aws_instance" "this" {
    for_each = var.ec2_parameter
    ami = each.value.ami
    instance_type = each.value.instance_type
    vpc_security_group_ids = each.value.vpc_security_group_ids
    subnet_id = each.value.subnet_id
    key_name = each.value.key_name
    tags = merge(each.value.tags,{
        Name: each.key
    })
}
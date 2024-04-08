module "vpc" {
  source = "./modules/vpc"
  vpc_parameter = {
    first_vpc = {
      cidr_block = "12.0.0.0/16"
      tags = {
        terraform : "True"
      }
    }
  }
  subnet_parameter = {
    public_ip = {
      cidr_block        = "12.0.1.0/24"
      availability_zone = "us-east-1a"
      vpc_name          = "first_vpc"
      tags = {
        terraform : "True"
      }
    }
  }
  internetGateWay_parameter = {
    first_gateway = {
      vpc_name = "first_vpc"
      tags = {
        terraform : "True"
      }
    }
  }
  routeTable_parameter = {
    public_routetable={
        vpc_name="first_vpc"
        tags = {
        terraform : "True"
      }
      route=[{
        cidr_block = "0.0.0.0/0"
        gateway_id= "first_gateway"
      }]
    }
  }
  routeTableAssociation_parameter = {
    first_association={
        routeTable_name="public_routetable"
        subnet_name="public_ip"
    }
  }
}


module "sg" {
    source = "./modules/security_group"
    securityGroup_parameter = {
        first_sg={
            vpc_id=module.vpc.vpcs.first_vpc.id
            ingress=[{
                from_port=22
                to_port=22
                cidr_blocks=["0.0.0.0/0"]
                protocol="tcp"
            },
            {from_port=80
                to_port=80
                cidr_blocks=["0.0.0.0/0"]
                protocol="tcp"

            },
            {
                from_port=443
                to_port=443
                cidr_blocks=["0.0.0.0/0"]
                protocol="tcp"
            }]
            egress=[{
                from_port=0
                to_port=0
                cidr_blocks=["0.0.0.0/0"]
                protocol="-1"
            }]
            tags={
                terraform= "True"
            }
        }
    }
}

module "ec2" {
    source = "./modules/ec2"
    ec2_parameter = {
      first_ec2={
        ami="ami-07d9b9ddc6cd8dd30"
        instance_type="t2.micro"
        subnet_id=module.vpc.subnets.public_ip.id
        vpc_security_group_ids=[module.sg.sg.first_sg.id]
        key_name="my-keypair"
        tags={
            terraform="True"
        }

      }
    }

}


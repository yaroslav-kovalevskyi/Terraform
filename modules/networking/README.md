## Description

This module creates basic networking infrastructure and includes next resources:

- VPC (65536 IP addresses are availabe there)
- Subnets divided to Public, Private, Database (4091 IP addresses are available for Public and Private subnets, 251 IP addresses are available for Database subnets)
- Route table to Internet for all Public subnets
- Internet gateway (is attached to VPC)

All resources has own tags to simplify their recogniziing in AWS Console;

Module creates the number of subnets according to the length of the appropriate variable;

Module provides you with outputs of VPC or Subnets IDs and ARNs

## Providers

| Name                                             | Version |
| ------------------------------------------------ | ------- |
| <a name="provider_aws"></a> [aws](#provider_aws) | latest  |

## Resources

| Name                                                                                                                                           | Type        |
| ---------------------------------------------------------------------------------------------------------------------------------------------- | ----------- |
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group)             | resource    |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway)                       | resource    |
| [aws_route_table.to_Internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table)                         | resource    |
| [aws_route_table_association.to_Internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource    |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                      | resource    |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                       | resource    |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet)                                        | resource    |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc)                                                | resource    |
| [aws_availability_zones.in_current_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones)  | data source |

## Inputs

| Name                                                                                          | Description                           | Type     | Default                                                                         | Required |
| --------------------------------------------------------------------------------------------- | ------------------------------------- | -------- | ------------------------------------------------------------------------------- | :------: |
| <a name="input_database_subnet_cidr"></a> [database_subnet_cidr](#input_database_subnet_cidr) | CIDR blocks for Database subnets      | `list`   | <pre>[<br> "10.0.100.0/24",<br> "10.0.200.0/24",<br> "10.0.255.0/24"<br>]</pre> |    no    |
| <a name="input_environment"></a> [environment](#input_environment)                            | Working environment \| 'dev' or 'prd' | `string` | n/a                                                                             |   yes    |
| <a name="input_private_subnet_cidr"></a> [private_subnet_cidr](#input_private_subnet_cidr)    | CIDR blocks for Private subnets       | `list`   | <pre>[<br> "10.0.112.0/20",<br> "10.0.128.0/20",<br> "10.0.144.0/20"<br>]</pre> |    no    |
| <a name="input_public_subnet_cidr"></a> [public_subnet_cidr](#input_public_subnet_cidr)       | CIDR blocks for Public subnets        | `list`   | <pre>[<br> "10.0.0.0/20",<br> "10.0.16.0/20",<br> "10.0.32.0/20"<br>]</pre>     |    no    |
| <a name="input_vpc_cidr"></a> [vpc_cidr](#input_vpc_cidr)                                     | CIDR block for VPC                    | `string` | `"10.0.0.0/16"`                                                                 |    no    |

## Outputs

| Name                                                                                            | Description                      |
| ----------------------------------------------------------------------------------------------- | -------------------------------- |
| <a name="output_Database_Subnet_ARNs"></a> [Database_Subnet_ARNs](#output_Database_Subnet_ARNs) | Provide all Database Subnets IDs |
| <a name="output_Database_Subnet_IDs"></a> [Database_Subnet_IDs](#output_Database_Subnet_IDs)    | Provide all Database Subnets IDs |
| <a name="output_Private_Subnet_ARNs"></a> [Private_Subnet_ARNs](#output_Private_Subnet_ARNs)    | Provide all Private Subnets IDs  |
| <a name="output_Private_Subnet_IDs"></a> [Private_Subnet_IDs](#output_Private_Subnet_IDs)       | Provide all Private Subnets IDs  |
| <a name="output_Public_Subnet_ARNs"></a> [Public_Subnet_ARNs](#output_Public_Subnet_ARNs)       | Provide all Public Subnets IDs   |
| <a name="output_Public_Subnet_IDs"></a> [Public_Subnet_IDs](#output_Public_Subnet_IDs)          | Provide all Public Subnets IDs   |
| <a name="output_VPC_ARN"></a> [VPC_ARN](#output_VPC_ARN)                                        | Provide VPC ARN                  |
| <a name="output_VPC_ID"></a> [VPC_ID](#output_VPC_ID)                                           | Provide VPC ID                   |

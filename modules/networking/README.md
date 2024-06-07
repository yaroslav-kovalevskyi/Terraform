## Description

This module creates basic networking infrastructure.

Resources overview:

*  VPC (65536 IP addresses are availabe there);
*  Subnets divided to Public, Private, Database (4091 IP addresses are available for Public and Private subnets, 251 IP addresses are available for Database subnets);
*  Route table to Internet for all Public subnets;
*  Internet gateway (is attached to VPC).

All resources have own tags to simplify their recognizing in AWS Console;

Module creates the number of subnets according to the length of the appropriate variable;

Module provides you with outputs of VPC or Subnets IDs and ARNs.

![networking](../../img/networking.png)

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.53.0 |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_internet_gateway.igw](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway) | resource |
| [aws_route_table.to_Internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table) | resource |
| [aws_route_table_association.to_Internet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table_association) | resource |
| [aws_subnet.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_subnet.public](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet) | resource |
| [aws_vpc.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc) | resource |
| [aws_availability_zones.in_current_region](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/availability_zones) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_database_subnet_cidr"></a> [database\_subnet\_cidr](#input\_database\_subnet\_cidr) | CIDR blocks for Database subnets | `list` | <pre>[<br>  "10.0.100.0/24",<br>  "10.0.200.0/24",<br>  "10.0.255.0/24"<br>]</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | Working environment \| 'dev' / 'prd' / 'test' | `string` | n/a | yes |
| <a name="input_private_subnet_cidr"></a> [private\_subnet\_cidr](#input\_private\_subnet\_cidr) | CIDR blocks for Private subnets | `list` | <pre>[<br>  "10.0.112.0/20",<br>  "10.0.128.0/20",<br>  "10.0.144.0/20"<br>]</pre> | no |
| <a name="input_project"></a> [project](#input\_project) | Name of Project | `string` | `""` | no |
| <a name="input_public_subnet_cidr"></a> [public\_subnet\_cidr](#input\_public\_subnet\_cidr) | CIDR blocks for Public subnets | `list` | <pre>[<br>  "10.0.0.0/20",<br>  "10.0.16.0/20",<br>  "10.0.32.0/20"<br>]</pre> | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | CIDR block for VPC | `string` | `"10.0.0.0/16"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database_subnet_group_properties"></a> [database\_subnet\_group\_properties](#output\_database\_subnet\_group\_properties) | List of **basic** Database Subnet Group Properties |
| <a name="output_database_subnets_properties"></a> [database\_subnets\_properties](#output\_database\_subnets\_properties) | List of **basic** Database Subnets Properties |
| <a name="output_private_subnets_properties"></a> [private\_subnets\_properties](#output\_private\_subnets\_properties) | List of **basic** Private Subnets Properties |
| <a name="output_public_subnets_properties"></a> [public\_subnets\_properties](#output\_public\_subnets\_properties) | List of **basic** Public Subnets Properties |
| <a name="output_vpc_properties"></a> [vpc\_properties](#output\_vpc\_properties) | List of **basic** VPC Properties |
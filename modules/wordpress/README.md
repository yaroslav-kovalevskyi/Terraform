## General

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider_aws)

- <a name="provider_local"></a> [local](#provider_local)

- <a name="provider_random"></a> [random](#provider_random)

- <a name="provider_tls"></a> [tls](#provider_tls)

## Resources

The following resources are used by this module:

- [aws_db_instance.main](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) (resource)
- [aws_elasticache_cluster.login_sessions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_cluster) (resource)
- [aws_elasticache_subnet_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_subnet_group) (resource)
- [aws_instance.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) (resource)
- [aws_key_pair.wordpress_ec2](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) (resource)
- [aws_route53_record.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) (resource)
- [aws_secretsmanager_secret.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) (resource)
- [aws_secretsmanager_secret_version.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) (resource)
- [aws_security_group.database](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (resource)
- [aws_security_group.redis](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (resource)
- [aws_security_group.wordpress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) (resource)
- [local_file.tf-key](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) (resource)
- [random_password.master_password](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) (resource)
- [tls_private_key.rsa](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) (resource)
- [aws_ami.ubuntu24lts](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) (data source)
- [aws_route53_zone.selected](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) (data source)

## Required Inputs

The following input variables are required to fill like

```
env_name = {
    key: value
}
```

### <a name="input_db_variables"></a> [db_variables](#input_db_variables)

Description: Map of database variables

Type: `map(string)`

Default: `{}`

### <a name="input_ec2_variables"></a> [ec2_variables](#input_ec2_variables)

Description: Map of EC2 variables

Type: `map(string)`

Default: `{}`

### <a name="input_general"></a> [general](#input_general)

Description: Map of general variables

Type: `map(string)`

Default: `{}`

### <a name="input_private_subnets"></a> [private_subnets](#input_private_subnets)

Description: List of Private Subnet IDs

Type: `list`

Default: `[]`

### <a name="input_redis_variables"></a> [redis_variables](#input_redis_variables)

Description: Map of Redis variables

Type: `map(string)`

Default: `{}`

### <a name="input_vpc_properties"></a> [vpc_properties](#input_vpc_properties)

Description: Map of VPC properties

Type: `map(string)`

Default: `{}`

## Optional Inputs

The following input variables are optional (have default values):

### <a name="input_internal_ports"></a> [internal_ports](#input_internal_ports)

Description: Map of internal / service ports for WordPress Server

Type: `map(string)`

Default:

```json
{
  "mysql": 3306,
  "redis": 6379
}
```

### <a name="input_public_ports"></a> [public_ports](#input_public_ports)

Description: Map of public ports for WordPress Server

Type: `map(string)`

Default:

```json
{
  "http": 80,
  "https": 443
}
```

### <a name="input_wellknown_ip"></a> [wellknown_ip](#input_wellknown_ip)

Description: Well known CIDR blocks to access resources without any blockers

Type: `map(string)`

Default: `{}`

## Outputs

No outputs
(temporarily)

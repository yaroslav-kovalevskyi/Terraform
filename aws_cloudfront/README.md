## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.50.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudfront_distribution.project_cloudfront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_distribution) | resource |
| [aws_cloudfront_origin_access_control.oac](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudfront_origin_access_control) | resource |
| [aws_iam_role.for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.extending_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lambda_function.content_handler](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |
| [aws_route53_record.cloudfront_records](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_s3_bucket.bucket_for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_acl.private](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_acl) | resource |
| [aws_s3_bucket_policy.only_cloudfront_has_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_object.lambda_to_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_object) | resource |
| [aws_acm_certificate.amazon_issued](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/acm_certificate) | data source |
| [aws_iam_policy.aws_managed_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy_document.for_lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.only_cloudfront_has_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_lb.lb_info](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/lb) | data source |
| [aws_route53_zone.project_hosted_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |
| [aws_s3_bucket.bucket_for_cloudfront](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/s3_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allowed_methods"></a> [allowed\_methods](#input\_allowed\_methods) | List of allowed HTTP methods | `list` | <pre>[<br>  "DELETE",<br>  "GET",<br>  "HEAD",<br>  "OPTIONS",<br>  "PATCH",<br>  "POST",<br>  "PUT"<br>]</pre> | no |
| <a name="input_alternate_project_domain_name"></a> [alternate\_project\_domain\_name](#input\_alternate\_project\_domain\_name) | Use in case project has content for Cloudfront, associated with another domain name | `string` | `""` | no |
| <a name="input_bucket_for_cloudfront"></a> [bucket\_for\_cloudfront](#input\_bucket\_for\_cloudfront) | Bucket for Cloudfront origin source | `string` | `""` | no |
| <a name="input_cached_methods"></a> [cached\_methods](#input\_cached\_methods) | Allowed caching methods | `list` | <pre>[<br>  "GET",<br>  "HEAD"<br>]</pre> | no |
| <a name="input_environment"></a> [environment](#input\_environment) | n/a | `any` | n/a | yes |
| <a name="input_lb_name"></a> [lb\_name](#input\_lb\_name) | LoadBalancer name for Cloudfront origin source | `any` | n/a | yes |
| <a name="input_max_ttl"></a> [max\_ttl](#input\_max\_ttl) | Maximum Time to Live (in seconds). Default TTL counts according to maximum TTL | `number` | `86400` | no |
| <a name="input_project_domain_name"></a> [project\_domain\_name](#input\_project\_domain\_name) | Main project domain name | `any` | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | The name of your project | `any` | n/a | yes |
| <a name="input_restricted_countries"></a> [restricted\_countries](#input\_restricted\_countries) | Countries with restricted access (according to ISO 3166 alpha-2 country code list) | `list(any)` | <pre>[<br>  "RU",<br>  "BY",<br>  "IR",<br>  "IQ"<br>]</pre> | no |
| <a name="input_sub_domains"></a> [sub\_domains](#input\_sub\_domains) | All sub domains which you want to use with Cloudfront | `list(any)` | `[]` | no |
| <a name="input_sub_domains_for_alternate_domain"></a> [sub\_domains\_for\_alternate\_domain](#input\_sub\_domains\_for\_alternate\_domain) | List of sub domains which should be associated with alternate domain name | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cloudfront_aliases"></a> [cloudfront\_aliases](#output\_cloudfront\_aliases) | n/a |

# kinesis-firehose-connector

The `kinesis-firehose-connector` module provisions dependencies for creating a Kinesis Firehose. It does NOT create the Firehose itself. You may use the `datadog-connector` for a Firehose which pipes to Datadog, or this connector + a custom Firehose for anything else.

To provide the Sym Runtime with access to the resources created in this `Connector`, use the `aws/kinesis-firehose` addon in the `runtime-connector` module.

```hcl
module "kinesis_firehose_connector" {
  source  = "symopsio/kinesis-firehose-connector/sym"
  version = ">= 2.0.0"

  environment = "sandbox"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 3.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_s3_bucket"></a> [s3\_bucket](#module\_s3\_bucket) | cloudposse/s3-bucket/aws | 0.44.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_policy.firehose_s3_access](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.firehose_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.aws_kinesis_firehose_s3_attach](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_uuid.bucket_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/uuid) | resource |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_environment"></a> [environment](#input\_environment) | An environment qualifier for the resources this module creates, to support a Terraform SDLC. | `string` | n/a | yes |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | A prefix for the Firehose dependency names | `string` | `""` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Additional tags to apply to resources. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_firehose_bucket_arn"></a> [firehose\_bucket\_arn](#output\_firehose\_bucket\_arn) | The ARN of the created S3 bucket to be used by the Firehose |
| <a name="output_firehose_role_arn"></a> [firehose\_role\_arn](#output\_firehose\_role\_arn) | The ARN of the created IAM role to be used by the Firehose |
<!-- END_TF_DOCS -->

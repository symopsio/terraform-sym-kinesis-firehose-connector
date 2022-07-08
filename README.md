# kinesis-firehose-connector

The `kinesis-firehose-connector` module provisions dependencies for creating a Kinesis Firehose. It does NOT create the Firehose itself. You may use the `datadog-connector` for a Firehose which pipes to Datadog, or this connector + a custom Firehose for anything else.

To provide the Sym Runtime with access to the resources created in this `Connector`, use the `aws/kinesis-firehose` addon in the `runtime-connector` module.

```hcl
module "kinesis_firehose_connector" {
  source  = "symopsio/kinesis-firehose-connector/sym"
  version = ">= 1.0.0"

  environment = "sandbox"
}
```

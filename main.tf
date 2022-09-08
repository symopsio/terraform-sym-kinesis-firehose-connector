# Kinesis Firehose requires an S3 bucket to be set as a backup storage location
resource "random_uuid" "bucket_suffix" {}

module "s3_bucket" {
  source  = "cloudposse/s3-bucket/aws"
  version = "0.44.0"

  acl                = "private"
  enabled            = true # Create resources
  versioning_enabled = false

  name               = "firehose-logs"
  namespace          = "sym"
  stage              = var.environment
  bucket_name        = "${lower(var.name_prefix)}sym-firehose-logs-${var.environment}-${random_uuid.bucket_suffix.id}"
  additional_tag_map = var.tags
}

# The IAM role the Firehose will assume
resource "aws_iam_role" "firehose_role" {
  name = "${var.name_prefix}SymKinesisFirehoseRole${title(var.environment)}"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

# The Firehose must have permission to push logs to the backup S3 bucket
resource "aws_iam_policy" "firehose_s3_access" {
  name = "${var.name_prefix}SymFirehoseS3AccessPolicy${title(var.environment)}"

  path        = "/sym/"
  description = "Policy granting access to write to S3 bucket"
  policy      = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:PutObject*"
      ],
      "Resource": [
        "${module.s3_bucket.bucket_arn}/*"
      ]
    }
  ]
}
EOT
}

resource "aws_iam_role_policy_attachment" "aws_kinesis_firehose_s3_attach" {
  policy_arn = aws_iam_policy.firehose_s3_access.arn
  role       = aws_iam_role.firehose_role.name
}

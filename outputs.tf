data "aws_region" "current" {}

output "firehose_role_arn" {
  description = "The ARN of the created IAM role to be used by the Firehose"
  value = aws_iam_role.firehose_role.arn
}

output "firehose_bucket_arn" {
  description = "The ARN of the created S3 bucket to be used by the Firehose"
  value = module.s3_bucket.bucket_arn
}

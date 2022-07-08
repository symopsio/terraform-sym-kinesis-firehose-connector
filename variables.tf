variable "environment" {
  description = "An environment qualifier for the resources this module creates, to support a Terraform SDLC."
  type        = string
}

variable "tags" {
  description = "Additional tags to apply to resources."
  type        = map(string)
  default     = {}
}

variable "name_prefix" {
  description = "A prefix for the Firehose dependency names"
  type        = string
  default     = ""
}

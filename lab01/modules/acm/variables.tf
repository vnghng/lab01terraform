# GENERAL
variable "project" {
  type        = string
  description = "Project name"
}

variable "service_name" {
  type        = string
  description = "Service name"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "aws_region" {
  type        = string
  description = "Region AWS"
}

# ACM
variable "create_certificate" {
  description = "Whether to create ACM certificate"
  type        = bool
}

variable "domain_name" {
  type        = string
  description = "A domain name for which the certificate should be issued"
}

variable "subject_alternative_names" {
  description = "A list of domains that should be SANs in the issued certificate"
  type        = list(string)
  default     = []
}

variable "validation_method" {
  description = "Which method to use for validation. DNS or EMAIL are valid, NONE can be used for certificates that were imported into ACM and then into Terraform."
  type        = string

  validation {
    condition     = contains(["DNS", "EMAIL", "NONE"], var.validation_method)
    error_message = "Valid values are DNS, EMAIL or NONE."
  }
}

variable "validation_option" {
  description = "The domain name that you want ACM to use to send you validation emails. This domain name is the suffix of the email addresses that you want ACM to use."
  type        = any
  default     = {}
}

variable "key_algorithm" {
  description = "Specifies the algorithm of the public and private key pair that your Amazon issued certificate uses to encrypt data"
  type        = string
  default     = null
}

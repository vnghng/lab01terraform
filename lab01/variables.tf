variable "project" {
  description = "Name of project"
  type        = string
}

variable "env" {
  description = "Name of project environment"
  type        = string
}

variable "account_id" {
  description = "ID of AWS account"
  type        = string
}

variable "region" {
  description = "Region of environment"
  type        = string
}

variable "solution_stack_name" {
  description = "Stack Name"
  type        = string
}

variable "tier" {
  description = "Tier"
  type        = string
}
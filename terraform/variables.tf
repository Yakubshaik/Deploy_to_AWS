variable "environment" {
  description = "The environment to deploy (dev, stage, prod)"
  type        = string
}

variable "lambda_function_name" {
  description = "The name of the Lambda function"
  type        = string
}

variable "lambda_handler" {
  description = "The Lambda function handler"
  type        = string
  default     = "app.lambda_handler"
}

variable "lambda_runtime" {
  description = "The Lambda function runtime"
  type        = string
  default     = "python3.8"
}

variable "region" {
  description = "AWS region"
  type        = string
}

variable "env_var_1" {
  description = "Environment variable 1"
  type        = string
}

variable "env_var_2" {
  description = "Environment variable 2"
  type        = string
}


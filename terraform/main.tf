provider "aws" {
  region = var.region
}

# Create S3 bucket for Lambda code
resource "aws_s3_bucket" "lambda_bucket" {
  bucket = "${var.environment}-lambda-deployments"
}

# Upload the Lambda zip package to S3
resource "aws_s3_bucket_object" "lambda_zip" {
  bucket = aws_s3_bucket.lambda_bucket.bucket
  key    = "${var.lambda_function_name}.zip"
  source = "../src/function.zip"   # Path to your zip package
}

# Create the Lambda function
resource "aws_lambda_function" "lambda_function" {
  function_name = var.lambda_function_name
  s3_bucket     = aws_s3_bucket.lambda_bucket.bucket
  s3_key        = aws_s3_bucket_object.lambda_zip.key
  handler       = var.lambda_handler
  runtime       = var.lambda_runtime
  role          = aws_iam_role.lambda_exec_role.arn

  environment {
    variables = {
      ENV_VAR_1 = var.env_var_1
      ENV_VAR_2 = var.env_var_2
    }
  }
}

# IAM role for Lambda function
resource "aws_iam_role" "lambda_exec_role" {
  name = "${var.environment}-lambda-exec-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action = "sts:AssumeRole",
      Effect = "Allow",
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

# IAM policy for Lambda function
resource "aws_iam_role_policy" "lambda_exec_policy" {
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action   = "logs:*",
      Effect   = "Allow",
      Resource = "*"
    }]
  })
}


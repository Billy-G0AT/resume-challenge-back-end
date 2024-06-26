#* Lambda Function IAM Role
resource "aws_iam_role" "this" {
  name               = "${var.function}-role"
  assume_role_policy = <<EOF
  {
    "Version": "2012-10-17",
    "Statement": [{
      "Effect": "Allow",
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      }
    }]
  }
EOF
}

#* Lambda Function Basic Execution Policy
resource "aws_iam_role_policy_attachment" "basic_execution" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#* Lambda Function DybanoDB Full Access Policy
resource "aws_iam_role_policy_attachment" "full_access" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

#* Zips Lambda Function
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "../lambda/visit_count_lambda_function.py"
  output_path = "../lambda/visit_count_lambda_function.zip"
}

#* Lambda Function
resource "aws_lambda_function" "this" {
  function_name = var.function
  role          = aws_iam_role.this.arn
  handler       = "visit_count_lambda_function.lambda_handler"
  runtime       = "python3.10"
  memory_size   = 128
  timeout       = 3
  filename      = data.archive_file.lambda.output_path
  source_code_hash = filebase64sha256(
    data.archive_file.lambda.output_path
  )
}

resource "aws_lambda_function" "calculate_occurrences" {
  filename         = "ex_lambda_calc_occr.zip"
  function_name    = "ex_lambda_calc_occr"
  role             = aws_iam_role.lambda_role.arn
  handler          = "ex_lambda_calc_occr.lambda_handler"
  runtime          = "python3.8"
  timeout          = 10
  memory_size      = 128

  source_code_hash = filebase64sha256("ex_lambda_calc_occr.zip")
}

resource "aws_iam_role" "lambda_role" {
  name = "lambda_role"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "lambda_policy_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "retrieve_result" {
  filename         = "ex_lambda_readbyid.zip"
  function_name    = "ex_lambda_readbyid"
  role             = aws_iam_role.lambda_role.arn
  handler          = "ex_lambda_readbyid.lambda_handler"
  runtime          = "python3.8"
  timeout          = 10
  memory_size      = 128

  source_code_hash = filebase64sha256("ex_lambda_readbyid.zip")
}

output "calculate_occurrences_lambda_arn" {
  value = aws_lambda_function.calculate_occurrences.arn
}

output "retrieve_result_lambda_arn" {
  value = aws_lambda_function.retrieve_result.arn
}

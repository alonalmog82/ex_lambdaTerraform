provider "archive" {}

data "archive_file" "zip_occr" {
  type        = "zip"
  source_file = "ex_lambda_calc_occr.py"
  output_path = "ex_lambda_calc_occr.zip"
}

data "archive_file" "zip_read" {
  type        = "zip"
  source_file = "ex_lambda_readbyid.py"
  output_path = "ex_lambda_readbyid.zip"
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    sid    = ""
    effect = "Allow"

    principals {
      identifiers = ["lambda.amazonaws.com"]
      type        = "Service"
    }

    actions = ["sts:AssumeRole", ]
  }
}

resource "aws_iam_role" "iam_for_lambda" {
  name               = "iam_for_lambda"
  assume_role_policy = "${data.aws_iam_policy_document.lambda_policy.json}"
}

resource "aws_iam_role_policy_attachment" "dynamodb_policy_attachment" {
  role       = aws_iam_role.iam_for_lambda.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"
}

resource "aws_lambda_function" "calculate_occurrences" {
  function_name    = "ex_lambda_calc_occr"
  filename         = "${data.archive_file.zip_occr.output_path}"
  source_code_hash = "${data.archive_file.zip_occr.output_base64sha256}"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "ex_lambda_calc_occr.lambda_handler"
  runtime          = "python3.9"
}

resource "aws_lambda_function" "retrieve_result" {
  function_name    = "ex_lambda_readbyid"
  filename         = "${data.archive_file.zip_read.output_path}"
  source_code_hash = "${data.archive_file.zip_read.output_base64sha256}"
  role             = "${aws_iam_role.iam_for_lambda.arn}"
  handler          = "ex_lambda_readbyid.lambda_handler"
  runtime          = "python3.9"
}
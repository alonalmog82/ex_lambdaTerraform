output "calculate_occurrences_lambda_arn" {
  value = aws_lambda_function.calculate_occurrences.arn
}

output "retrieve_result_lambda_arn" {
  value = aws_lambda_function.retrieve_result.arn
}

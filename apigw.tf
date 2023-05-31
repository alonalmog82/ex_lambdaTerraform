resource "aws_api_gateway_rest_api" "exercise_api" {
  name        = "exercise-api"
  description = "Exercise API Gateway"
}

resource "aws_api_gateway_resource" "calc_resource" {
  rest_api_id = aws_api_gateway_rest_api.exercise_api.id
  parent_id   = aws_api_gateway_rest_api.exercise_api.root_resource_id
  path_part   = "calculate-number-of-occurrences"
}

resource "aws_api_gateway_resource" "get_resource" {
  rest_api_id = aws_api_gateway_rest_api.exercise_api.id
  parent_id   = aws_api_gateway_rest_api.exercise_api.root_resource_id
  path_part   = "get-number-of-occurrences"
}

resource "aws_api_gateway_method" "calc_method" {
  rest_api_id   = aws_api_gateway_rest_api.exercise_api.id
  resource_id   = aws_api_gateway_resource.calc_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_method" "get_method" {
  rest_api_id   = aws_api_gateway_rest_api.exercise_api.id
  resource_id   = aws_api_gateway_resource.get_resource.id
  http_method   = "POST"
  authorization = "NONE"
}


resource "aws_api_gateway_integration" "exercise_post_integration" {
  rest_api_id = aws_api_gateway_rest_api.exercise_api.id
  resource_id = aws_api_gateway_resource.calc_resource.id
  http_method = aws_api_gateway_method.calc_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.calculate_occurrences.invoke_arn
}

resource "aws_api_gateway_integration" "exercise_get_integration" {
    rest_api_id = aws_api_gateway_rest_api.exercise_api.id
    resource_id = aws_api_gateway_resource.get_resource.id
    http_method = aws_api_gateway_method.get_method.http_method
    integration_http_method = "POST"
    type                    = "AWS_PROXY"
    uri                     = aws_lambda_function.retrieve_result.invoke_arn
}

resource "aws_api_gateway_deployment" "exercise_deployment" {
  depends_on    = [aws_api_gateway_integration.exercise_post_integration]
  rest_api_id   = aws_api_gateway_rest_api.exercise_api.id
  stage_name    = "prod"
}

output "api_gateway_invoke_url" {
  value = aws_api_gateway_deployment.exercise_deployment.invoke_url
}

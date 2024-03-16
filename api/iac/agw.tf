resource "aws_api_gateway_rest_api" "agw" {
  for_each = { for name in var.mode : name => name }
  tags     = merge(var.tags, {})
  name     = "${var.agw_name}-${each.key}"
}


resource "aws_api_gateway_resource" "agw_resource" {
  for_each    = { for name in var.mode : name => name }
  rest_api_id = aws_api_gateway_rest_api.agw[each.key].id
  path_part   = <<EOT
{proxy+}

EOT
  parent_id   = aws_api_gateway_rest_api.agw[each.key].root_resource_id
}

resource "aws_api_gateway_method" "agw_method" {
  for_each      = { for name in var.mode : name => name }
  rest_api_id   = aws_api_gateway_rest_api.agw[each.key].id
  resource_id   = aws_api_gateway_resource.agw_resource[each.key].id
  http_method   = "ANY"
  authorization = "NONE"

}

resource "aws_api_gateway_integration" "agw_integration" {
  for_each                = { for name in var.mode : name => name }
  uri                     = aws_lambda_function.lambda[each.key].invoke_arn
  type                    = "AWS_PROXY"
  rest_api_id             = aws_api_gateway_rest_api.agw[each.key].id
  resource_id             = aws_api_gateway_resource.agw_resource[each.key].id
  integration_http_method = "ANY"
  http_method             = aws_api_gateway_method.agw_method[each.key].http_method
}


resource "aws_api_gateway_deployment" "agw_deployment" {
  for_each    = { for name in var.mode : name => name }
  stage_name  = each.key
  rest_api_id = aws_api_gateway_rest_api.agw[each.key].id

  triggers = {
    redeployment = local.timestamp
  }
  depends_on = [aws_api_gateway_integration.agw_integration]

}

resource "aws_api_gateway_method_response" "response_200" {
  for_each    = { for name in var.mode : name => name }
  rest_api_id = aws_api_gateway_rest_api.agw[each.key].id
  resource_id = aws_api_gateway_resource.agw_resource[each.key].id
  http_method = aws_api_gateway_method.agw_method[each.key].http_method
  status_code = "200"
  depends_on = [
    aws_api_gateway_rest_api.agw,
    aws_api_gateway_resource.agw_resource,
    aws_api_gateway_method.agw_method,
  ]
}

resource "aws_api_gateway_integration_response" "response_200" {
  for_each    = { for name in var.mode : name => name }
  rest_api_id = aws_api_gateway_rest_api.agw[each.key].id
  resource_id = aws_api_gateway_resource.agw_resource[each.key].id
  http_method = aws_api_gateway_method.agw_method[each.key].http_method
  status_code = aws_api_gateway_method_response.response_200[each.key].status_code


  response_templates = {
    "application/json" = "EMPTY"
  }

  depends_on = [
    aws_api_gateway_rest_api.agw,
    aws_api_gateway_resource.agw_resource,
    aws_api_gateway_method.agw_method,
    aws_api_gateway_method_response.response_200,
    aws_api_gateway_integration.agw_integration
  ]
}

resource "aws_lambda_permission" "agw_lambda_permission" {
  for_each      = { for name in var.mode : name => name }
  source_arn    = "${aws_api_gateway_rest_api.agw[each.key].execution_arn}/*/*/*"
  principal     = "apigateway.amazonaws.com"
  function_name = aws_lambda_function.lambda[each.key].arn
  action        = "lambda:InvokeFunction"
}

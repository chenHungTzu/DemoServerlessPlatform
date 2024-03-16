resource "aws_lambda_function" "lambda" {
  for_each      = { for name in var.mode : name => name }
  timeout       = 30
  tags          = merge(var.tags, {})
  role          = aws_iam_role.lambda_role[each.key].arn
  package_type  = "Image"
  memory_size   = 512
  image_uri     = "${aws_ecr_repository.ecr[each.key].repository_url}:latest"
  function_name = "${var.lambda_name}-${each.key}"
  handler       = "DemoServerlessPlatform::DemoServerlessPlatform.LambdaEntryPoint::FunctionHandlerAsync"
  environment {
    variables = {
      MODE = "${each.key}"
      TZ   = "Asia/Taipei"
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  for_each           = { for name in var.mode : name => name }
  tags               = merge(var.tags, {})
  assume_role_policy = <<EOT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOT
}


resource "aws_iam_role_policy" "lambda_role_policy" {
  for_each = { for name in var.mode : name => name }
  role     = aws_iam_role.lambda_role[each.key].name
  policy   = <<EOT
{
      "Version": "2012-10-17",
      "Statement": [
        {
         "Effect": "Allow",
         "Action": [
            "dynamodb:BatchGetItem",
            "dynamodb:BatchWriteItem",
            "dynamodb:ConditionCheckItem",
            "dynamodb:DeleteItem",
            "dynamodb:DeleteTable",
            "dynamodb:DescribeStream",
            "dynamodb:DescribeTable",
            "dynamodb:GetItem",
            "dynamodb:ListGlobalTables",
            "dynamodb:ListStreams",
            "dynamodb:ListTables",
            "dynamodb:ListTagsOfResource",
            "dynamodb:PutItem",
            "dynamodb:Query",
            "dynamodb:Scan",
            "dynamodb:UpdateItem",
            "dynamodb:UpdateTable",
            "dynamodb:UpdateTimeToLive"
          ],
          "Resource": [
              "${aws_dynamodb_table.dynamodb_table0[each.key].arn}",
              "${aws_dynamodb_table.dynamodb_table1[each.key].arn}",
              "${aws_dynamodb_table.dynamodb_table2[each.key].arn}"
          ]
        }
      ]
}

EOT
}

resource "aws_iam_role_policy_attachment" "lambda_role_basic_policy" {
  for_each   = { for name in var.mode : name => name }
  role       = aws_iam_role.lambda_role[each.key].name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

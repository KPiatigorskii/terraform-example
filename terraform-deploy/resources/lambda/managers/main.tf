module "manager_plan" {
  source                              = "../lambda_function_module"
  function_name                       = "${var.stage}-manager-plan"
  lambda_source_path    = "../../../backend/managers/manager.plan/"
  lambda_output_path    = "./resources/lambda/managers/zip_files/planmanager/planmanager.zip"
  role_arn                           = aws_iam_role.lambda_role.arn
  timeout = 120
  environment_variables = {
    PLANACCESSOR_NAME = "${var.stage}-accessor-plan"
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = module.manager_plan.lambda_function_arn
  principal     = "apigateway.amazonaws.com"
  depends_on = [ module.manager_plan ]
}


resource "aws_iam_role" "lambda_role" {
  name = "${var.stage}-manager-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect  = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action  = "sts:AssumeRole"
      },
    ]
  })

  inline_policy {
    name = "${var.stage}-manager-inline-policy"
    policy = jsonencode({
      Version = "2012-10-17",
      Statement = [
        {
          Effect = "Allow",
          Action = [
            "lambda:InvokeFunction",
          ],
          Resource = "*",
        },
        {
          Effect = "Allow",
          Action = [
            "dynamodb:*",
          ],
          Resource = "*",
        },
        {
          Effect = "Allow",
          Action = [
            "logs:CreateLogGroup",
            "logs:CreateLogStream",
            "logs:PutLogEvents",
          ],
          Resource = "*",
        },
      ],
    })
  }
}
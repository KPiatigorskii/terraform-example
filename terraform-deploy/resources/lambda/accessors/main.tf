module "accessor_notification" {
  source                              = "../lambda_function_module"
  function_name                       = "${var.stage}-accessor-notification"
  lambda_source_path    = "../../../backend/accessors/accessor.notification/"
  lambda_output_path    = "./resources/lambda/accessors/zip_files/notificationaccessor/notificationaccessor.zip"
  role_arn              = aws_iam_role.lambda_role.arn
  environment_variables = {
    PLANACCESSOR_NAME = "${var.stage}-accessor-plan"
    DYNAMODB_ENDPOINT = "dynamodb.us-east-1.amazonaws.com"
  }
}

module "accessor_plan" {
  source                              = "../lambda_function_module"
  function_name                       = "${var.stage}-accessor-plan"
  lambda_source_path    = "../../../backend/accessors/accessor.plan/"
  lambda_output_path    = "./resources/lambda/accessors/zip_files/planaccessor/planaccessor.zip"
  role_arn              = aws_iam_role.lambda_role.arn
  environment_variables = {
    NOTIFICATIONACCESSOR_NAME = "${var.stage}-accessor-notification"
    DYNAMODB_ENDPOINT = "dynamodb.us-east-1.amazonaws.com"
  }
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.stage}-accessor-role"

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
    name = "${var.stage}-accessor-inline-policy"
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
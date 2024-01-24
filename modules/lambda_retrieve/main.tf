resource "aws_iam_role" "lambda_role" {
  name = "${var.project_code}-${var.env_name}-role-lambda-weather_retrieve"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_lambda_function" "retrieve_lambda" {
  filename      = "../../app/lambda_retrieve.zip" 
  function_name = "${var.project_code}-${var.env_name}-weather_retrieve"
  role          = aws_iam_role.lambda_role.arn
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"

  source_code_hash = filebase64sha256("../../app/lambda_retrieve.zip")

  environment {
    variables = {
      OUTPUT_BUCKET =  var.bucket-etl-in-bucket
    }
  }

} 
  


# Additional CloudWatch policy
resource "aws_iam_policy" "lambda_cloudwatch_policy" {
  name        = "${var.project_code}-${var.env_name}-lambda_weather_retrieve_cloudwatch_policy"
  description = "IAM policy for logging from a lambda weather_retrieve to CloudWatch"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Action = [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      Resource = "arn:aws:logs:*:*:*"
    }]
  })
}


resource "aws_iam_role_policy_attachment" "lambda_cloudwatch_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_cloudwatch_policy.arn
}


resource "aws_iam_policy" "lambda_s3_policy" {
  name        = "${var.project_code}-${var.env_name}-lambda_execute_policy"
  description = "IAM policy for Lambda to access S3 buckets"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ],
        Resource = [
          "${var.bucket-etl-in-arn}/*"
        ]
      } 
    ]
  })
}
resource "aws_iam_role_policy_attachment" "lambda_s3_attachment" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_s3_policy.arn
}


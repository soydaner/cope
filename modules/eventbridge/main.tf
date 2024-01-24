resource "aws_cloudwatch_event_rule" "every_weekday" {
  name                = "every-weekday-5am"
  description         = "Triggers every weekday at 5 AM"
  schedule_expression = "cron(0 5 ? * MON-FRI *)"
}

resource "aws_cloudwatch_event_target" "lambda" {
  rule = aws_cloudwatch_event_rule.every_weekday.name
  arn  = var.lambda_arn
}

resource "aws_lambda_permission" "allow_cloudwatch_to_call_lambda" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.every_weekday.arn
}

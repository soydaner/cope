output "etl-in-id" {
  value       = aws_s3_bucket.etl-in.id
}
output "etl-in-arn" {
  value       = aws_s3_bucket.etl-in.arn
}

output "etl-out-bucket" {
  value       = aws_s3_bucket.etl-out.bucket
}
output "etl-out-arn" {
  value       = aws_s3_bucket.etl-out.arn
}

output "etl-in-bucket" {
  value       = aws_s3_bucket.etl-in.bucket
}
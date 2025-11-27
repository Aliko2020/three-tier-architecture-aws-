output "website_endpoint" {
  description = "The HTTP endpoint of the static website"
  value       = aws_s3_bucket.website_bucket.website_endpoint
}

output "website_url" {
  description = "The URL of the static website"
  value       = "http://${aws_s3_bucket.website_bucket.website_endpoint}"
}

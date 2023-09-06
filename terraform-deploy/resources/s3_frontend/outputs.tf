output "cloudfront_url_output" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

output "uploaded_files" {
  value = fileset("${path.root}/../../../frontend/offra/dist/offra/", "**/*")
}

output "uploaded_files_path" {
  value = "${path.root}/../../../frontend/offra/dist/offra/"
}
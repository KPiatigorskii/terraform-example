output "manager_plan_arn" {
  value = module.lambda.manager_plan_function_arn
}

output "cloudfront_frontend_url" {
  value = module.frontend.cloudfront_url_output
}

output "uploaded_frontend_files" {
  value = module.frontend.uploaded_files
}

output "uploaded_frontend_path" {
  value = module.frontend.uploaded_files_path
}
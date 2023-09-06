# https://registry.terraform.io/providers/-/aws/latest/docs/resources/s3_bucket

# resource "aws_s3_bucket" "terraform-s3-bucket" {
#   bucket = "${var.stage}-${var.bucket_name}"

#   tags = {
#     Name        = "My bucket"
#     Environment = "Dev"
#   }
# }

# # Grant read access to the Terraform state bucket to the specific IAM user/role
# resource "aws_s3_bucket_policy" "my_bucket_policy" {
#   bucket = aws_s3_bucket.my_bucket.id

#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [{
#       Sid       = "AllowTerraformStateAccess",
#       Effect    = "Allow",
#       Principal = {
#         AWS = "arn:aws:iam::YOUR_ACCOUNT_ID:role/YourRoleName"
#       },
#       Action    = "s3:GetObject",
#       Resource  = "${aws_s3_bucket.my_bucket.arn}/*"
#     }]
#   })
# }
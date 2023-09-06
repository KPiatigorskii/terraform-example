resource "aws_s3_bucket" "angular_app" {
  bucket = "${var.stage}-angular-app-bucket" 
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.angular_app.bucket

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = {
          AWS = "arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity ${aws_cloudfront_origin_access_identity.oai.iam_arn}"
        },
        Action   = "s3:GetObject",
        Resource = "${aws_s3_bucket.angular_app.arn}/*",
      }
    ]
  })
}

locals {
  mime_types = {
    ".html" = "text/html",
    ".css"  = "text/css",
    ".js"   = "application/javascript",
    ".json" = "application/json",
    ".png"  = "image/png",
    ".jpg"  = "image/jpeg",
  }
}

resource "aws_s3_bucket_object" "angular_app_objects" {
  for_each = fileset("${path.root}/../../../frontend/offra/dist/offra/", "**/*") 
  bucket  = aws_s3_bucket.angular_app.bucket
  key     = each.value
  source  = "${path.root}/../../../frontend/offra/dist/offra/${each.value}" 
  content_type = lookup(local.mime_types, regex("\\.[^.]+$", each.value), "application/octet-stream")

}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "OAI for ${aws_s3_bucket.angular_app.bucket}"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket.angular_app.bucket_domain_name
    origin_id   = "S3-${aws_s3_bucket.angular_app.bucket}"
    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "Angular App Distribution"
  default_root_object = "index.html"

    default_cache_behavior {
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-${aws_s3_bucket.angular_app.bucket}"

        forwarded_values {
            query_string = false
            headers      = []
            cookies {
            forward = "none"
            }
        }

        viewer_protocol_policy = "redirect-to-https"
        min_ttl                = 0
        default_ttl            = 3600
        max_ttl                = 86400
    }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }
}

output "cloudfront_url" {
  value = aws_cloudfront_distribution.s3_distribution.domain_name
}

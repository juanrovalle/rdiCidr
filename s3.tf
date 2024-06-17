resource "aws_s3_bucket" "bucket" {
  bucket        = var.bucket_name
  force_destroy = true
}
# file upload
resource "aws_s3_object" "file" {
  for_each     = fileset("${path.module}/build", "**/*.{html,css,js,json,svg}")
  bucket       = aws_s3_bucket.bucket.id
  key          = replace(each.value, "^build/", "")
  source       = "${path.module}/build/${each.value}"
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), "application/octet-stream")
  source_hash  = filemd5("${path.module}/build/${each.value}")
}

resource "aws_s3_bucket_website_configuration" "terraform_hosting" {
  bucket = aws_s3_bucket.bucket.id

  index_document {
    suffix = var.key_file
  }
}

locals {
  content_types = {
    ".html" : "text/html"
    ".css" : "text/css",
    ".js" : "text/javacript",
    ".svg" : "image/svg+xml",
    ".json" : "application/json"
  }
}

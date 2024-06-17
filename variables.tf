variable "bucket_name" {
  default = "prod-fullstacklabs-demo-002"
}
variable "key_file" {
  default = "index.html"
}
variable "content_type" {
  default = "text/html"
}
variable "block_public_acls" {
  default = "false"
}
variable "block_public_policy" {
  default = "false"
}
variable "ignore_public_acls" {
  default = "false"
}
variable "restrict_public_buckets" {
  default = "false"
}
variable "policy_action" {
  default = "s3:GetObject"
}

# Website URL
output "website_url" {
  value = "http://${aws_s3_bucket.bucket.bucket}.s3-website.${aws_s3_bucket.bucket.region}.amazonaws.com"
}
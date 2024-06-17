resource "aws_s3_bucket_public_access_block" "terraform-demo" {
  bucket                  = aws_s3_bucket.bucket.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

resource "aws_s3_bucket_policy" "open_access" {
  bucket = aws_s3_bucket.bucket.id

  policy = jsonencode(
    {
      "Id" : "Public_access",
      "Version" : "2012-10-17",
      "Statement" = [
        {
          "Sid" : "IPALLOW",
          "Action" : [var.policy_action]
          "Effect" : "Allow",
          "Resource" : "${aws_s3_bucket.bucket.arn}/*"
          "Principal" : "*"
        },
      ]
    })
  depends_on = [aws_s3_bucket_public_access_block.terraform-demo]

}


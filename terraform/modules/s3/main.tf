
resource "aws_s3_bucket" "website_bucket" {
  bucket = var.bucket_name

  tags = {
    Project = "StaticWebsite"
  }
}

resource "aws_s3_bucket_website_configuration" "website_config" {
  bucket = aws_s3_bucket.website_bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# Configure public access settings: disable all blocks
resource "aws_s3_bucket_public_access_block" "public_access_block" {
  bucket = aws_s3_bucket.website_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}


resource "aws_s3_bucket_ownership_controls" "ownership_controls" {
  bucket = aws_s3_bucket.website_bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.website_bucket.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "PublicReadGetObject"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.website_bucket.arn}/*"
      }
    ]
  })

  depends_on = [
    aws_s3_bucket_public_access_block.public_access_block,
    aws_s3_bucket_ownership_controls.ownership_controls,
  ]
}

# Upload website files to the bucket
resource "aws_s3_object" "website_files" {
  for_each = fileset("./website-content/", "**/*")
  bucket   = aws_s3_bucket.website_bucket.id
  key      = each.value
  source   = "${path.module}/website-content/${each.value}"
  etag     = filemd5("${path.module}/website-content/${each.value}") 
  content_type = lookup(local.content_types, regex("\\.[^.]+$", each.value), "binary/octet-stream") 
}


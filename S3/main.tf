# Get current AWS account ID
data "aws_caller_identity" "current" {}

# S3 Bucket
resource "aws_s3_bucket" "profile_app_bucket" {
  bucket = "profile-app-uploads-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "Profile App Uploads"
    Environment = "production"
  }
}

# IAM User for S3 access
resource "aws_iam_user" "profile_app_user" {
  name = "profile-app-s3-user"
  path = "/"

  tags = {
    Name        = "Profile App S3 User"
    Environment = "production"
  }
}

resource "aws_s3_bucket_public_access_block" "profile_app_bucket_public_access_block" {
  bucket = aws_s3_bucket.profile_app_bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
output "bucket_name" {
# Bucket Naming Rules
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  value = aws_s3_bucket.website_bucket.bucket
}

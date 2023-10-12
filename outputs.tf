output "random_bucket_name" {
# Bucket Naming Rules
# https://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html
  value = random_string.bucket_name.result
}

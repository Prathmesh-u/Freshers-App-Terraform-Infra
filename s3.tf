resource "aws_s3_bucket" "artifact_bucket" {
  bucket = var.s3_bucket

  tags = {
    Name = "App Artifact Bucket"
  }
}

resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.artifact_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

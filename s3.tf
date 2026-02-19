
resource "aws_s3_bucket" "my_first_bucket" {
  # Use your name + random numbers to make it unique (S3 names must be unique globally)
  bucket = "akshay-devops-project-101" 

  tags = {
    Name        = "My First DevOps Bucket"
    Environment = "Dev"
  }
}

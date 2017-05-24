variable "region" {
  default = "eu-west-1"
}

variable "domain_name" {
  default = "https://s3-eu-west-1.amazonaws.com/conortek.net/"
}

variable "bucket_name" {
  default = "https://s3-eu-west-1.amazonaws.com/conortek.net/"
}

provider "aws" {
  access_key = "${ACCESS_KEY_ID}"
  secret_key = "${AWS_SECRET_ACCESS_KEY}"
  region = "${var.region}"
}

resource "aws_s3_bucket" "bucket" {
  bucket = "${var.bucket_name}"
  region = "${var.region}"
  acl = "public-read"
  website {
    index_document = "index.html"
    error_document = "error.html"
  }
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [{
    "Sid": "PublicReadForGetBucketObjects",
    "Effect": "Allow",
    "Principal": "*",
    "Action": "s3:GetObject",
    "Resource": ["arn:aws:s3:::${var.bucket_name}/*"]
  }]
}
EOF
}

#Random ID for unique naming
resource "random_integer" "rand" {
  min = 1000
  max = 9999
}

locals {
  common_tags = {
    project = "${var.project}"
  }

  s3_bucket_name = "webserver-${random_integer.rand.result}"
}



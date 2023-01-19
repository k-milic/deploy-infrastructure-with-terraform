#Random ID for unique naming
resource "random_integer" "rand" {
  min = 1000
  max = 9999
}

locals {
  projects = var.project

  s3_bucket_name = "webserver-${random.integer.rand.result}"
}



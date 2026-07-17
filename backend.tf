terraform {
  backend "s3" {
    bucket       = "terraform-webs"
    key          = "state"
    region       = "ap-south-1"
    use_lockfile = true
  }
}

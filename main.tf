terraform {
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "MeetRajput"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "MeetRajput"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
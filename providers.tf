terraform {
  #  backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"
  
  #  cloud {
  #   organization = "MeetRajput"
  #   workspaces {
  #     name = "terra-house-1"
  #   }
  # }
  required_providers {
#    random = {
#      source = "hashicorp/random"
#      version = "3.5.1"
#    }
     aws = {
      source = "hashicorp/aws"
      version = "5.20.0"
     }
   }
}
provider "aws" {
  # Configuration options
}

provider "random" {
  # Configuration options
}

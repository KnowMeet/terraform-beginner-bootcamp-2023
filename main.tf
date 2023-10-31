terraform {

  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
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

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token= var.terratowns_access_token
}

 module "terrahouse_aws" {
   source = "./modules/terrahouse_aws"
   user_uuid = var.teacherseat_user_uuid
   index_html_filepath = var.index_html_filepath
   error_html_filepath = var.error_html_filepath
   content_version = var.content_version
   assets_path = var.assets_path
 }

resource "terratowns_home" "home" {
  name = "One of my favourite games of all time - Mini Milita"
  description = <<DESCRIPTION
Mini Militia, a pocket-sized powerhouse of a game, packs a punch with its fast-paced multiplayer battles and a variety of weapons, power-ups, and maps.
It became a sensation before the era of PUBG and Fortnite, thanks to its easy accessibility, cross-platform play, and addictive gameplay that perfectly suited mobile gaming.
With friends or foes, you'll find yourself engrossed in thrilling combat, where quick reflexes and strategy rule the day. 
It's a timeless classic that made mobile gaming a battleground of fun and excitement.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  town = "missingo"
  content_version = 1
}
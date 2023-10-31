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
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

# module "terrahouse_aws" {
#   source = "./modules/terrahouse_aws"
#   user_uuid = var.user_uuid
#   bucket_name = var.bucket_name
#   index_html_filepath = var.index_html_filepath
#   error_html_filepath = var.error_html_filepath
#   content_version = var.content_version
#   assets_path = var.assets_path
# }

resource "terratowns_home" "home" {
  name = "One of my favourite games of all time - Mini Milita!"
  description = <<DESCRIPTION
Mini Militia, a pocket-sized powerhouse of a game, packs a punch with its fast-paced multiplayer battles and a variety of weapons, power-ups, and maps.
It became a sensation before the era of PUBG and Fortnite, thanks to its easy accessibility, cross-platform play, and addictive gameplay that perfectly suited mobile gaming.
With friends or foes, you'll find yourself engrossed in thrilling combat, where quick reflexes and strategy rule the day. 
It's a timeless classic that made mobile gaming a battleground of fun and excitement.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}
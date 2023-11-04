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

  cloud {
    organization = "MeetRajput"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid= var.teacherseat_user_uuid
  token= var.terratowns_access_token
}

module "home_mini-militia" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.mini-militia.public_path
  content_version = var.mini-militia.content_version
}

resource "terratowns_home" "home" {
  name = "One of my favourite games of all time - Mini Milita"
  description = <<DESCRIPTION
Mini Militia, a pocket-sized powerhouse of a game, packs a punch with its fast-paced multiplayer battles and a variety of weapons, power-ups, and maps.
It became a sensation before the era of PUBG and Fortnite, thanks to its easy accessibility, cross-platform play, and addictive gameplay that perfectly suited mobile gaming.
With friends or foes, you'll find yourself engrossed in thrilling combat, where quick reflexes and strategy rule the day. 
It's a timeless classic that made mobile gaming a battleground of fun and excitement.
DESCRIPTION
  domain_name = module.home_mini-militia.domain_name
  town = "missingo"
  content_version = var.mini-militia.content_version
}

  module "home_whiplash" {
    source = "./modules/terrahome_aws"
    user_uuid = var.teacherseat_user_uuid
    public_path = var.whiplash.public_path
    content_version = var.whiplash.content_version
  }
  
  resource "terratowns_home" "home_whip" {
    name = "One of my favourite movies of all time - Whiplash"
    description = <<DESCRIPTION
  Why 'Whiplash' is my all-time favorite movie: It's a mesmerizing celebration of the obsessed artist. 
  This film powerfully captures the sacrifices and unwavering dedication required to achieve greatness. 
  Miles Teller and J.K. Simmons' performances are a symphony of passion and obsession. 
  If you love stories of unyielding ambition, 'Whiplash' is a must-watch." 🎵🎥🥁 
  DESCRIPTION
    domain_name = module.home_whiplash.domain_name
    town = "missingo"
    content_version = var.whiplash.content_version
  }
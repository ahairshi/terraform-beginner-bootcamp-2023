terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  # backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  # }
  cloud {
   organization = "ahairshi"
   workspaces {
     name = "terra-house-1"
   }
  }

}

 provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_tennis_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.tennis.public_path
  content_version = var.tennis.content_version
}

resource "terratowns_home" "home" {
  name = "Tennis Legends"
  description = <<DESCRIPTION
This shows list of all tennis players with 10+ Grandslam, with how many titles they have won..
DESCRIPTION
  domain_name = module.home_tennis_hosting.domain_name
  town = "missingo"
  content_version = var.tennis.content_version
}

module "home_spotify_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.spotify.public_path
  content_version = var.spotify.content_version
}

resource "terratowns_home" "home_spotify" {
  name = "Tamil Independent Song - Spotify"
  description = <<DESCRIPTION
Explore and immerse yourself in the rhythms of Tamil independent music right here.
DESCRIPTION
  domain_name = module.home_spotify_hosting.domain_name
  town = "melomaniac-mansion"
  content_version = var.spotify.content_version
}

module "home_movie_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.movie.public_path
  content_version = var.movie.content_version
}

resource "terratowns_home" "home_movie" {
  name = "Random Malayalam Movies"
  description = <<DESCRIPTION
Welcome to the Malayalam Cinema Showcase – a curated space celebrating the rich tapestry of Malayalam cinema. Malayalam films, known for their intricate storytelling, deep-rooted cultural nuances, and unparalleled craftsmanship, have carved a niche in the global cinematic arena. 
DESCRIPTION
  domain_name = module.home_movie_hosting.domain_name
  town = "video-valley"
  content_version = var.movie.content_version
}
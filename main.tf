terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  #cloud {
  #  organization = "ExamPro"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

}

 provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  #bucket_name = var.bucket_name
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}

resource "terratowns_home" "home" {
  name = "International Tennis Hall of Fame!"
  description = <<DESCRIPTION
The International Tennis Hall of Fame is located in Newport, Rhode Island, USA. 
It honors players and contributors to the sport of tennis and serves as a museum for tennis history.

The Hall of Fame was established in 1954 and has inducted a wide range of individuals including players, 
coaches, administrators, and other major contributors to the sport of tennis.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "d1tgc3z7m4cndc.cloudfront.net"
  town = "missingo"
  content_version = 1
}
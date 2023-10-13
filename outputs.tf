output "bucket_name_tennis" {
  description = "Bucket name for our static website hosting"
  value = module.home_tennis_hosting.bucket_name
}

output "s3_website_endpoint_tennis" {
  description = "S3 Static Website hosting endpoint"
  value = module.home_tennis_hosting.website_endpoint
}

output "cloudfront_url_tennis" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_tennis_hosting.domain_name
}

output "bucket_name_spotify" {
  description = "Bucket name for our static website hosting"
  value = module.home_spotify_hosting.bucket_name
}

output "s3_website_endpoint_spotify" {
  description = "S3 Static Website hosting endpoint"
  value = module.home_spotify_hosting.website_endpoint
}

output "cloudfront_url_spotify" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_spotify_hosting.domain_name
}

output "bucket_name_movie" {
  description = "Bucket name for our static website hosting"
  value = module.home_movie_hosting.bucket_name
}

output "s3_website_endpoint_movie" {
  description = "S3 Static Website hosting endpoint"
  value = module.home_movie_hosting.website_endpoint
}

output "cloudfront_url_movie" {
  description = "The CloudFront Distribution Domain Name"
  value = module.home_movie_hosting.domain_name
}
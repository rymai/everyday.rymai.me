desc "Download the 'Everyday' photos from S3"
task download_everyday_set_photos: :environment do
  puts "Downloading photos from S3..."
  FlickrAPI.download_from_s3
  puts "Done!"
end

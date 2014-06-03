desc "Move public everyday photos to the 'Everyday' set and backup them to S3"
task move_public_everyday_photos_into_set: :environment do
  puts "Moving public everyday photos to the 'Everyday' set..."
  Photo.move_public_everyday_photos_into_set
  puts "Done!"

  puts "Backuping the 'Everyday' photos to S3..."
  Photo.backup_everyday_set_to_s3
  puts "Done!"
end

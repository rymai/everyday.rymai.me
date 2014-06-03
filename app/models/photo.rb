class Photo

  def self.public_everyday_photos
    @public_everyday_photos ||= FlickrAPI.search(user_id: '97103729@N00', text: 'Taken with Everyday', privacy_filter: :public)
  end

  def self.move_public_everyday_photos_into_set
    FlickrAPI.move_photos_into_set(public_everyday_photos, PhotoSet.new('Everyday'))
    @public_everyday_photos = nil
  end

  def self.backup_everyday_set_to_s3
    FlickrAPI.backup_to_s3(PhotoSet.new('Everyday'))
  end

end

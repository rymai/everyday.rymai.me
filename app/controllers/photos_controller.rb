class PhotosController < ApplicationController
  caches_page :dashboard

  def dashboard
    @public_everyday_photos = Photo.public_everyday_photos
  end

  private

  def everyday_photoset
    PhotoSet.new('Everyday')
  end
  helper_method :everyday_photoset

end

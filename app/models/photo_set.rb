class PhotoSet

  def initialize(name)
    @flickr_set = FlickrAPI.set(name)
  end

  def photos
    if @photos.nil?
      @photos = []
      page, fetch_next_page = 1, true

      while fetch_next_page && photos = FlickrAPI.photos_in_set(@flickr_set, page)
        @photos += photos
        page += 1
        fetch_next_page = photos.size == 500
      end
    end

    @photos
  end

  def size
    photos.size
  end

  def skipped_photos_count_since(date)
    [((Time.now.utc - date) / (3600*24)).floor - size, 0].max
  end

  def respond_to?(name)
    @flickr_set.respond_to?(name) || super
  end

  def method_missing(name, *args)
    if @flickr_set.respond_to? name
      @flickr_set.send name, *args
    else
      super
    end
  end

end

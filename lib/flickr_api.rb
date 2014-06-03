module FlickrAPI

  class << self

    PRIVACY_LEVEL = { public: 1 }
    MONTHS        = %W[janvier fevrier mars avril mai juin juillet aout septembre octobre novembre decembre]

    def test
      flickr.test
    end

    def set(title)
      @sets ||= {}
      @sets[title] ||= flickr.photosets.get_list.detect { |set| set.title == title }
    end

    def photos_in_set(photoset, page = 1)
      puts "Fetching page #{page}"
      photoset.get_photos(extras: 'date_taken, url_sq', page: page)
    end

    def search(options = {})
      exclude = options.delete(:exclude)

      options[:privacy_filter] = PRIVACY_LEVEL[options[:privacy_filter]]
      photos = flickr.photos.search(options).photos

      if exclude.respond_to? :include?
        photos.reject! { |p| exclude.include?(p.id) }
      end

      photos
    end

    def move_photos_into_set(photos, photoset = set('Everyday'), options = {})
      photos.each do |photo|
        begin
          flickr.send_request('flickr.photosets.addPhoto', options.merge(photoset_id: photoset.id, photo_id: photo.id))
          flickr.send_request('flickr.photos.setPerms', options.merge(photo_id: photo.id, is_public: 0, is_friend: 0, is_family: 0, perm_comment: 0, perm_addmeta: 0))
        rescue Flickr::Error => ex
          Rails.logger.info ex
        end
      end
      Rails.cache.clear
    end

    def backup_to_s3(photoset)
      photoset.photos.pop(90).each do |photo|
        filename = title_to_filename(photo.title)
        unless s3_directory.files.head("#{S3Wrapper.prefix}#{filename}.jpg")
          file = Tempfile.new(filename, encoding: 'ascii-8bit')
          begin
            puts "Downloading #{photo.url} from Flickr..."
            file.write(Net::HTTP.get(URI(photo.url)))
            puts "Uploading #{filename} to S3 => #{S3Wrapper.prefix}#{filename}.jpg..."
            s3_directory.files.create(key: "#{S3Wrapper.prefix}#{filename}.jpg", body: file)
          ensure
            file.close
            file.unlink
          end
        else
          puts "#{S3Wrapper.prefix}#{filename} is already backed-up, skip!"
        end
      end

      true
    end

    def download_from_s3
      s3_directory.files.each do |s3_file|
        next unless s3_file.key =~ %r{^#{S3Wrapper.prefix}}

        filename = Rails.root.join(S3Wrapper.local_dir, s3_file.key)
        unless File.exists?(filename)
          Rails.logger.debug "Downloading #{s3_file.key} from S3 and save it to #{filename}..."
          File.open(filename, 'w', encoding: 'ascii-8bit') do |local_file|
            local_file.write(s3_file.body)
          end
        else
          Rails.logger.debug "#{filename} is already saved locally, skip!"
        end
      end

      true
    end

    private

    def flickr
      @flickr ||= Flickr.new(Rails.root.join('config/flickr.yml').to_s)
    end

    def storage
      @storage ||= Fog::Storage.new(provider: 'AWS',
                                    aws_access_key_id: S3Wrapper.aws_access_key_id,
                                    aws_secret_access_key: S3Wrapper.aws_secret_access_key)
    end

    def s3_directory
      @s3_directory ||= storage.directories.get(S3Wrapper.bucket)
    end

    def title_to_filename(title)
      day, month, year = title.split(' ')

      "#{year.to_i}_#{MONTHS.index(sligize_string(month)) + 1}_#{day.to_i}"
    end

    def sligize_string(str)
      ActiveSupport::Multibyte::Chars.new(str).normalize(:kd).gsub(/[^\x00-\x7F]/,'').to_s.downcase
    end

  end

end

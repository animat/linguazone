class FlickrSearch
  CREATIVE_COMMONS_LICENSE_ID = 2
  def self.search(value)
    photos = flickr.photos.search(:text => value, :tags => value, :license_id => CREATIVE_COMMONS_LICENSE_ID)
  end
end


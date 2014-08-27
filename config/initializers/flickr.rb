require 'flickraw'
FlickRaw.api_key = 'd09e5b97529e3ace79ad3c0e9f1ea1c2'
FlickRaw.shared_secret = '1a0f1686c361e083'

# monkey patch FlickRaw to have a url method
module FlickRaw
  class Response
    def photo_url
      "http://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}.jpg"
    end

    def thumbnail_url
      "http://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_t.jpg"
    end

    def url
      "http://flickr.com/photo.gne?id=#{id}"
    end
  end
end

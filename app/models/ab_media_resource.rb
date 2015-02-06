class AbMediaResource < ActiveRecord::Base
  belongs_to :post
  before_save { |media| 
    if media.source == "YouTube"
      media.embed = YouTubeAddy.extract_video_id(media.embed)
      media.embed = "" if media.embed.class == Array
    end
  }
end

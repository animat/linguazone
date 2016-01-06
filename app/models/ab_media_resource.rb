class AbMediaResource < ActiveRecord::Base
  belongs_to :post
  before_save { |media| 
    if media.source == "YouTube"
      media.embed = YouTubeAddy.extract_video_id(media.embed)
      media.embed = "" if media.embed.class == Array
    end
  }
  
  has_attached_file :pic, styles: {
    thumb: '100x100>',
    square: '200x200#',
    large: '600x600>'
  }
  
  validates_attachment_content_type :pic, :content_type => /\Aimage\/.*\Z/
end

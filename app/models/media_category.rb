class MediaCategory < ActiveRecord::Base
  has_many :medias, :class_name => "Media"
  # TODO @Len: postgres doesn't like this. Any thoughts?
  scope :active, :joins => :medias, :group => "medias.media_category_id", :having => "count(medias.media_category_id) > 0"
end

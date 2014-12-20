class MediaCategory < ActiveRecord::Base
  has_many :medias, :class_name => "Media"

  scope :active, -> { where("media_count > 0") }
end

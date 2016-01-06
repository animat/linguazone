class Comment < ActiveRecord::Base
  belongs_to :available_post
  belongs_to :user
  has_many :audio_clips
  
  has_many :sources, :as => :sourceable
end

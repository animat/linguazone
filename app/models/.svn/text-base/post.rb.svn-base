class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :audio_clips
  belongs_to :course
  
  validates_presence_of :title
end

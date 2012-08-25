class Post < ActiveRecord::Base
  has_many :audio_clips
  belongs_to :course
  
  validates_presence_of :title
  
  def header_text
    "#{self.title}"
  end
  
  def description_text
    "#{self.content}".truncate(250, :separator => " ")
  end
end

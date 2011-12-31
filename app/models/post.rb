class Post < ActiveRecord::Base
  has_many :comments, :dependent => :destroy
  has_many :audio_clips
  belongs_to :course
  
  validates_presence_of :title
  
  def header_text
    "#{self.title}"
  end
  
  #TODO: Truncate this text at length 300 separator " "
  def description_text
    "#{self.content}"
  end
end

class AvailableGame < ActiveRecord::Base
  belongs_to :course
  belongs_to :game
  belongs_to :user
  
  has_many :sources, :as => :sourceable
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
  
  scope :on_course, lambda { |c_id| where("course_id = ?", c_id) }
  
  def parent_assoc
    game
  end
  
end

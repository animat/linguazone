class AvailableGame < ActiveRecord::Base
  belongs_to :course
  belongs_to :game
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
  
  
end

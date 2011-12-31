class AvailableGame < ActiveRecord::Base
  belongs_to :course
  belongs_to :game
  belongs_to :user
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
  
  def parent_assoc
    game
  end
  
end

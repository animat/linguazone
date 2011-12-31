class AvailablePost < ActiveRecord::Base
  belongs_to :course
  belongs_to :post
  belongs_to :user
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
  
  def parent_assoc
    post
  end
end

class AvailablePost < ActiveRecord::Base
  belongs_to :course
  belongs_to :post
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
end

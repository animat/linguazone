class AvailablePost < ActiveRecord::Base
  belongs_to :course
  belongs_to :post
  # TODO Maybe: We can students to still be able to access comments even if the teacher deleted the associated post, right?
  has_many :comments
  belongs_to :user
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
  
  def parent_assoc
    post
  end
end

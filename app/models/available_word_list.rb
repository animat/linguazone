class AvailableWordList < ActiveRecord::Base
  belongs_to :course
  belongs_to :word_list
  belongs_to :user
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
end

class AvailableWordList < ActiveRecord::Base
  belongs_to :course
  belongs_to :word_list
  
  scope :showing, lambda {
    where("hidden = ?", 0)
  }
end

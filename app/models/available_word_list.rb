class AvailableWordList < ActiveRecord::Base
  belongs_to :course
  belongs_to :word_list
  belongs_to :user
  has_many :study_histories
  
  scope :showing, lambda {
    where("hidden = ?", false)
  }
  
  scope :on_course, lambda { |c_id| where("course_id = ?", c_id) }
  
  def parent_assoc
    word_list
  end
  
  def gradebook_column_header
    word_list.description
  end
end

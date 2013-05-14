class AvailableWordList < ActiveRecord::Base
  belongs_to :course
  belongs_to :word_list
  belongs_to :user

  scope :showing, lambda { where("hidden = ?", false)
  }

  scope :on_course, lambda { |c_id| where("course_id = ?", c_id) }

  def self.for(course)
    self.includes(:word_list).showing.on_course(course.id).order("word_lists.updated_at DESC")
  end

  def parent_assoc
    word_list
  end
end

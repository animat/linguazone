class CourseRegistration < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  scope :students_in_course, lambda { |course_id| where(:course_id => course_id) }
end
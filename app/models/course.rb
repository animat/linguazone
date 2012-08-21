class Course < ActiveRecord::Base
  #belongs_to :teacher, :class_name => :user
  #has_many :students, :class_name => :user, :through => :course_registrations
  belongs_to :user
  has_many :course_registrations
  has_many :available_posts
  has_many :available_games
  has_many :available_word_lists
  
  validates_presence_of :name
  validates_presence_of :code, :if => Proc.new { |course| course.login_required }, :message => "is blank. Create a class code, then tell it to your students so they can login and access the class page."
  
  def self.find_courses_at_school(school)
    teacher_ids = User.all(:conditions => ["school_id = ? and role = ?", school.id, "teacher"]).map { |t| t.id }
    courses = Course.all(:conditions => {:user_id => teacher_ids}, :order => "ordering asc, name asc")
  end
    
end

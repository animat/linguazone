class AvailablePost < ActiveRecord::Base
  belongs_to :course
  belongs_to :post
  # TODO Maybe: We can students to still be able to access comments even if the teacher deleted the associated post, right?
  has_many :comments
  belongs_to :user
  
  has_many :sources, :as => :sourceable
  
  scope :showing, lambda {
    where("hidden = ?", false)
  }
  
  scope :on_course, lambda { |c_id| where("available_posts.course_id = ?", c_id) }
  
  def as_json(options)
    super(:include => {:post => {:only => [:title, :content]}})
  end
  
  def parent_assoc
    post
  end
  
  def gradebook_column_header
    post.title
  end
end

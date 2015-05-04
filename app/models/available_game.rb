class AvailableGame < ActiveRecord::Base
  belongs_to :course
  belongs_to :game
  belongs_to :user
  has_many :high_scores
  
  scope :showing, lambda {
    where("hidden = ?", false)
  }
  
  scope :on_course, lambda { |c_id| where("course_id = ?", c_id) }
  
  def as_json(options)
    super(:include => {:game => {
                          :include => { :activity => { :only => [:name, :swf]}},
                        :only => [:description]}})
  end
  
  def parent_assoc
    game
  end
  
  def gradebook_column_header
    game.description
  end
end

class School < ActiveRecord::Base
  belongs_to :state
  has_many :users
  has_many :courses, :through => :users
  
  validates_presence_of :name, :address, :city, :zip
  validates_numericality_of :zip

  # TODO: this should be tied to subscriptions
  def subscribers
    self.users
  end
  
  # TODO: this should take into consideration more than just the first teacher found
  def subscription
    if subscribers.length > 0
      subscribers[0].subscription
    else
      nil
    end
  end
  
  # TODO: Don't count accounts that are coordinators/ are not enabled
  def available_spaces
    self.subscription.subscription_plan.max_teachers - self.subscribers.length
  end
  
  def is_availability?
    if self.subscription.subscription_plan.max_teachers == -1
      return true
    else
      available_spaces > 0
    end
  end
  
end

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
  
  def subscription
    if subscribers.length > 0
      subscribers[0].subscription
    else
      nil
    end
  end
  
  def available_spaces
    self.subscription.subscription_plan.max_teachers - self.subscribers.length # Don't count accounts that aren't enabled/ coordinators
  end
  
  def is_availability?
    if self.subscription.subscription_plan.max_teachers == -1
      return true
    else
      available_spaces > 0
    end
  end
  
end

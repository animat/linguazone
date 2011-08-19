class SubscriptionPlan < ActiveRecord::Base
  has_many :subscriptions

  validates_presence_of :cost

  def self.trial
    self.find(:first, :conditions => {:name => "trial"} )
  end
end

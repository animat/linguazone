class SubscriptionPlan < ActiveRecord::Base
  has_many :subscriptions

  def self.trial
    self.find(:first, :conditions => {:name => "trial"} )
  end
end

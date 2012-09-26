class SubscriptionPlan < ActiveRecord::Base
  UNLIMITED_FLAG = -1

  has_many :subscriptions

  validates_presence_of :cost
  
  scope :trial_sub, where("subscription_plans.name = ?", "trial")
  scope :basic_sub, where("subscription_plans.name = ?", "basic")
  scope :premium_sub, where("subscription_plans.name = ?", "premium")
  scope :paid_sub, where("subscription_plans.name != ?", "trial")

  def self.trial
    self.find(:first, :conditions => {:name => "trial"} )
  end

  def upgrades
    if unlimited_teachers?
      return [] if premium?
      return self.class.all(:conditions => ["(max_teachers = ? AND name = ?)", UNLIMITED_FLAG, "premium"])
    end

    premium_condition = premium? ? " AND name = 'premium'" : " OR (name = 'premium' and (max_teachers >= #{self.max_teachers} OR max_teachers = #{UNLIMITED_FLAG}))"
    self.class.all(:conditions => ["(max_teachers > ? OR max_teachers = #{UNLIMITED_FLAG}) #{premium_condition}", self.max_teachers])
  end

  private
    def premium?
      self.name == "premium"
    end

    def unlimited_teachers?
      self.max_teachers == UNLIMITED_FLAG
    end
    
end

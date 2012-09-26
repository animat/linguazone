class Subscription < ActiveRecord::Base

  has_many :users
  belongs_to :subscription_plan
  
  scope :days_remaining, lambda { |d|
    where("subscriptions.expired_at BETWEEN ? and ?", DateTime.now.beginning_of_day + d.to_i.days, DateTime.now.end_of_day + d.to_i.days)
  }
  
  def is_expired?
    self.expired_at < Time.now
  end

  def trial?
    self.subscription_plan.name == "trial"
  end
  
  def number_of_teachers
    (self.max_teachers == UNLIMITED_FLAG) ? "unlimited" : self.max_teachers.to_s
  end
  
  def extend_one_year
    if self.expired_at < Time.now
      self.expired_at = Time.now.advance(:years => 1)
    else
      self.expired_at.advance(:years => 1)
    end
  end
  
  def school
    @teacher = User.first(:conditions => ["subscription_id = ?", self.id])
    @teacher.school
  end

  def self.send_reminder_emails
    @two_week_subs = User.joins(:subscription, :subscription_plan).merge(Subscription.days_remaining(14)).merge(SubscriptionPlan.paid_sub)
    unless @two_week_subs.empty?
      InvoiceMailer.two_week_reminder(@two_week_subs).deliver
    end
    
    @one_week_subs = User.joins(:subscription, :subscription_plan).merge(Subscription.days_remaining(7)).merge(SubscriptionPlan.paid_sub)
    unless @one_week_subs.empty?
      InvoiceMailer.one_week_reminder(@one_week_subs).deliver
    end
    
    @two_day_subs = User.joins(:subscription, :subscription_plan).merge(Subscription.days_remaining(2)).merge(SubscriptionPlan.paid_sub)
    unless @two_day_subs.empty?
      InvoiceMailer.two_day_reminder(@two_day_subs).deliver
    end
    
    @one_week_trials = User.joins(:subscription, :subscription_plan).merge(Subscription.days_remaining(7)).merge(SubscriptionPlan.trial_sub)
    unless @one_week_trials.empty?
      InvoiceMailer.trial_one_week_reminder(@one_week_trials).deliver
    end
    
    @three_day_trials = User.joins(:subscription, :subscription_plan).merge(Subscription.days_remaining(3)).merge(SubscriptionPlan.trial_sub)
    unless @three_day_trials.empty?
      InvoiceMailer.trial_three_day_reminder(@three_day_trials).deliver
    end
    
    @expired_trials = User.joins(:subscription, :subscription_plan).merge(Subscription.days_remaining(-1)).merge(SubscriptionPlan.trial_sub)
    unless @expired_trials.empty?
      InvoiceMailer.trial_expired_reminder(@expired_trials).deliver
    end
  end

end

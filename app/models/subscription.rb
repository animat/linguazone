class Subscription < ActiveRecord::Base

  has_many :users
  belongs_to :subscription_plan

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
    @two_week_subs = User.all(:conditions => ["email = ?", "info@linguazone.com"])
    unless @two_week_subs.empty?
      @two_week_subs.each do |u|
        InvoiceMailer.two_week_reminder("colinangevine@gmail.com", u, u.subscription).deliver
      end
    end

    @one_week_subs = User.all(:conditions => ["email = ?", "info@linguazone.com"])
    unless @one_week_subs.empty?
      @one_week_subs.each do |u|
        InvoiceMailer.one_week_reminder("colinangevine@gmail.com", u, u.subscription).deliver
      end
    end

    @two_day_subs = User.all(:conditions => ["email = ?", "info@linguazone.com"])
    unless @two_day_subs.empty?
      @two_day_subs.each do |u|
        InvoiceMailer.two_day_reminder("colinangevine@gmail.com", u, u.subscription).deliver
      end
    end

    # @one_week_trials = User.all(:conditions => ["email = ?", "info@linguazone.com"])
    #     unless @one_week_trials.empty?
    #       @one_week_trials.each do |u|
    #         InvoiceMailer.trial_one_week_reminder("colinangevine@gmail.com", u, u.subscription).deliver
    #       end
    #     end
    #
    #     @three_day_trials = User.all(:conditions => ["email = ?", "info@linguazone.com"])
    #     unless @three_day_trials.empty?
    #       @three_day_trials.each do |u|
    #         InvoiceMailer.trial_three_day_reminder("colinangevine@gmail.com", u, u.subscription).deliver
    #       end
    #     end
    #
    #     @expired_trials = User.all(:conditions => ["email = ?", "info@linguazone.com"])
    #     unless @expired_trials.empty?
    #       @expired_trials.each do |u|
    #         InvoiceMailer.trial_expired_reminder("colinangevine@gmail.com", u, u.subscription).deliver
    #       end
    #     end
  end

end

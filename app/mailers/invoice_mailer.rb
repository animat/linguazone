class InvoiceMailer < ActionMailer::Base
  helper :application
  default :from    => "LinguaZone.com <info@linguazone.com>"
  default :reply_to => "info@linguazone.com"

  def trial_confirmation(email_addr, user)
    @user = user
    mail :to => email_addr, :subject => "Starting your trial at LinguaZone.com"
  end

  def trial_details(user)
    @user = user
    mail :to => "colinangevine@gmail.com, magistraroberts@hotmail.com, liz@linguazone.com", :subject => "New trial subscription at LinguaZone.com"
  end

  def new_invoice(email_addr, user, subscription, cost)
    @subscription = subscription
    @cost = cost
    @user = user
    mail :to => email_addr, :subject => "LinguaZone.com Invoice"
  end

  def upgrade_invoice(email_addr, user, subscription, cost)
    @subscription = subscription
    @cost = cost
    @user = user
    mail :to => email_addr, :subject => "LinguaZone.com Invoice"
  end

  def extend_invoice(email_addr, user, subscription, cost)
    @subscription = subscription
    @cost = cost
    @user = user
    mail :to => email_addr, :subject => "LinguaZone.com Invoice"
  end

  def two_week_reminder(users)
    users.each do |u|
      @user = u
      @subscription = u.subscription
      mail :to => @user.email, :from => "Colin Angevine <info@linguazone.com>", :subject => "Time to renew your LinguaZone subscription"
    end
  end

  def one_week_reminder(users)
    users.each do |u|
      @user = u
      @subscription = u.subscription
      mail :to => @user.email, :from => "Colin Angevine <info@linguazone.com>", :subject =>  "One week left: renew your LinguaZone subscription"
    end
  end

  def two_day_reminder(users)
    users.each do |u|
      @user = u
      @subscription = u.subscription
      mail :to => @user.email, :from => "Colin Angevine <info@linguazone.com>", :subject => "Checking in about your subscription to LinguaZone"
    end
  end

  def trial_one_week_reminder(users)
    users.each do |u|
      @user = u
      @subscription = u.subscription
      mail :to => @user.email, :subject => "One week left in your trial at LinguaZone.com"
    end
  end

  def trial_three_day_reminder(users)
    users.each do |u|
      @user = u
      @subscription = u.subscription
      mail :to => @user.email, :subject => "Three days left in your trial at LinguaZone.com"
    end
  end

  def trial_expired_reminder(users)
    users.each do |u|
      @user = u
      @subscription = u.subscription
      mail :to => @user.email, :subject => "Subscribing to LinguaZone.com"
    end
  end
  
  def expiration_admin_update(notified_users)
    @users = notified_users
    mail :to => "info@linguazone.com", :subject => "LZ expiration notices"
  end
end

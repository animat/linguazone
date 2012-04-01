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
    mail :to => "colinangevine@gmail.com, magistraroberts@hotmail.com", :subject => "New trial subscription at LinguaZone.com"
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

  def two_week_reminder(email_addr, user, subscription)
    @user = user
    @subscription = user
    mail :to => email_addr, :from => "Colin Angevine <info@linguazone.com>", :subject => "Time to renew your LinguaZone subscription"
  end

  def one_week_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    mail :to => email_addr, :from => "Colin Angevine <info@linguazone.com>", :subject =>  "One week left: renew your LinguaZone subscription"
  end

  def two_day_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    mail :to => email_addr, :from => "Colin Angevine <info@linguazone.com>", :subject => "Checking in about your subscription to LinguaZone"
  end

  def trial_one_week_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    mail :to => email_addr, :subject => "One week left in your trial at LinguaZone.com"
  end

  def trial_three_day_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    mail :to => email_addr, :subject => "Three days left in your trial at LinguaZone.com"
  end

  def trial_expired_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    mail :to => email_addr, :subject => "Subscribing to LinguaZone.com"
  end
end

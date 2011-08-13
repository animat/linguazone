class InvoiceMailer < ActionMailer::Base
  helper :application

  def trial_confirmation(email_addr, user)
    @user = user
    recipients    email_addr
    from          "LinguaZone.com"
    reply_to      "info@linguazone.com"
    subject       "Starting your trial at LinguaZone.com"
    body          :user => user
    content_type  "text/html"
  end

  def trial_details(user)
    @user = user
    recipients    "colinangevine@gmail.com, magistraroberts@hotmail.com"
    from          "LinguaZone.com"
    reply_to      "info@linguazone.com"
    subject       "New trial subscription at LinguaZone.com"
    body          :user => user
    content_type  "text/html"
  end

  def new_invoice(email_addr, user, subscription, cost)
    @subscription = subscription
    @cost = cost
    @user = user
    recipients    email_addr
    from          "LinguaZone.com"
    reply_to      "info@linguazone.com"
    subject       "LinguaZone.com Invoice"
    body          :user => user, :subscription => subscription, :cost => cost
    content_type  "text/html"
  end

  def upgrade_invoice(email_addr, user, subscription, cost)
    @subscription = subscription
    @cost = cost
    @user = user
    recipients    email_addr
    from          "LinguaZone.com"
    reply_to      "info@linguazone.com"
    subject       "LinguaZone.com Invoice"
    body          :user => user, :subscription => subscription, :cost => cost
    content_type  "text/html"
  end

  def extend_invoice(email_addr, user, subscription, cost)
    @subscription = subscription
    @cost = cost
    @user = user
    recipients    email_addr
    from          "LinguaZone.com"
    reply_to      "info@linguazone.com"
    subject       "LinguaZone.com Invoice"
    body          :user => user, :subscription => subscription, :cost => cost
    content_type  "text/html"
  end

  def two_week_reminder(email_addr, user, subscription)
    @user = user
    recipients    email_addr
    from          "Colin Angevine <info@linguazone.com>"
    headers       "return-path" => 'info@linguazone.com'
    reply_to      "info@linguazone.com"
    subject       "Time to renew your LinguaZone subscription"
    body          :user => user, :subscription => subscription
    content_type  "text/html"
  end

  def one_week_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    recipients    email_addr
    from          "Colin Angevine <info@linguazone.com>"
    headers       "return-path" => 'info@linguazone.com'
    reply_to      "info@linguazone.com"
    subject       "One week left: renew your LinguaZone subscription"
    body          :user => user, :subscription => subscription
    content_type  "text/html"
  end

  def two_day_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    recipients    email_addr
    from          "Colin Angevine <info@linguazone.com>"
    headers       "return-path" => 'info@linguazone.com'
    reply_to      "info@linguazone.com"
    subject       "Checking in about your subscription to LinguaZone"
    body          :user => user, :subscription => subscription
    content_type  "text/html"
  end

  def trial_one_week_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    recipients    email_addr
    from          "Colin Angevine <info@linguazone.com>"
    headers       "return-path" => 'info@linguazone.com'
    reply_to      "info@linguazone.com"
    subject       "One week left in your trial at LinguaZone.com"
    body          :user => user, :subscription => subscription
    content_type  "text/html"
  end

  def trial_three_day_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    recipients    email_addr
    from          "Colin Angevine <info@linguazone.com>"
    headers       "return-path" => 'info@linguazone.com'
    reply_to      "info@linguazone.com"
    subject       "Three days left in your trial at LinguaZone.com"
    body          :user => user, :subscription => subscription
    content_type  "text/html"
  end

  def trial_expired_reminder(email_addr, user, subscription)
    @user = user
    @subscription = subscription
    recipients    email_addr
    from          "Colin Angevine <info@linguazone.com>"
    headers       "return-path" => 'info@linguazone.com'
    reply_to      "info@linguazone.com"
    subject       "Subscribing to LinguaZone.com"
    body          :user => user, :subscription => subscription
    content_type  "text/html"
  end
end

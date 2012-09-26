Given /^the (trial|basic|premium) subscription for "(.*?)" will expire in (\d+) (weeks?|days?)$/ do |acct_type, email, time_left, time_unit|
  @u = User.find_by_email(email)
  @u.subscription.expired_at = Time.now.advance(time_unit.pluralize.to_sym => time_left.to_i)
  @u.subscription.subscription_plan = SubscriptionPlan.find_by_name(acct_type)
  @u.subscription.save
end

Given /^the (trial|basic|premium) subscription for "(.*?)" expired yesterday$/ do |acct_type, email|
  @u = User.find_by_email(email)
  @u.subscription.expired_at = Time.now.advance(:days => -1)
  @u.subscription.subscription_plan = SubscriptionPlan.find_by_name(acct_type)
  @u.subscription.save
end

When /^the reminder emails are sent$/ do
  #NightlyReminderEmails.new
  Subscription.send_reminder_emails
end
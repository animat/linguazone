class NightlyReminderEmails
  
  def perform
    #InvoiceMailer.trial_one_week_reminder(User.one_week_remaining).deliver
    # TODO @Len: Is it best to do this here? Or in the subscription.rb model?
  end
  
end
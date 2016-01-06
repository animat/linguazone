namespace :nightly_reminders do
  
  desc "Send nightly reminder emails to all users and admin"
  task :send_notices => :environment do
    Subscription.send_reminder_emails
    puts "Reminder emails have been sent at #{Time.now}"
  end
  
end
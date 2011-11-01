Linguazone::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.action_controller.perform_caching             = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = true
  
  config.serve_static_assets = true
  config.active_support.deprecation = :notify

  ActionMailer::Base.delivery_method = :smtp

  ActionMailer::Base.sendmail_settings = {
    :location       => '/usr/sbin/sendmail',
    :arguments      => '-i -t'
  }

  ActionMailer::Base.smtp_settings = {
    :address              => "spring.joyent.us",
    :port                 => 25,
    :domain               => "spring.joyent.us",
    :user_name            => "info-linguazone",
    :password             => "tamina01",
    :authentication       => :plain
  }
end

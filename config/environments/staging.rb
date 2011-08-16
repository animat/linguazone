Linguazone::Application.configure do

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = false

  config.action_controller.perform_caching             = true
  config.action_view.cache_template_loading            = true
  config.action_mailer.perform_deliveries = true

  ActionMailer::Base.delivery_method = :smtp

  ActionMailer::Base.smtp_settings = {
    :address              => "spring.joyent.us",
    :port                 => 25,
    :domain               => "spring.joyent.us",
    :user_name            => "info-linguazone",
    :password             => "tamina01",
    :authentication       => :plain
  }
end


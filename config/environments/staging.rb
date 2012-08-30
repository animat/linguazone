Linguazone::Application.configure do

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = false

  config.action_controller.perform_caching             = true
  config.action_view.cache_template_loading            = true
  config.action_mailer.perform_deliveries = true
  config.action_mailer.default_url_options = { :host => "linguazone-staging.heroku.com" }
end


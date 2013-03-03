Linguazone::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = false
  config.serve_static_assets = true
  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  config.assets.compress = false
  config.assets.debug = true
end


silence_warnings do
  IRB = Pry
end



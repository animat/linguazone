Linguazone::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.action_controller.perform_caching             = false
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_deliveries = false
  
  config.serve_static_assets = true
  config.active_support.deprecation = :notify
end

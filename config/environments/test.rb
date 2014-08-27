Linguazone::Application.configure do
  config.cache_classes                                 = false
  config.whiny_nils                                    = true
  config.action_controller.perform_caching             = false
  config.action_view.cache_template_loading            = true
  config.action_controller.allow_forgery_protection    = false
  config.action_mailer.delivery_method                 = :test
  config.active_support.deprecation                    = :stderr
  config.assets.compress = false
  config.assets.debug = true
  config.serve_static_assets = true
end

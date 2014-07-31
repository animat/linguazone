Linguazone::Application.configure do

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  config.action_controller.perform_caching             = true
  config.action_view.cache_template_loading            = true
  config.action_mailer.perform_deliveries              = true
  
  config.assets.precompile += %w[active_admin.css active_admin.js]
  config.assets.initialize_on_precompile = false

  config.action_mailer.default_url_options = { :host => "www.linguazone.com" }
  
  if ENV["MEMCACHEDCLOUD_SERVERS"]
      config.cache_store = :dalli_store, ENV["MEMCACHEDCLOUD_SERVERS"].split(','), { :username => ENV["MEMCACHEDCLOUD_USERNAME"], :password => ENV["MEMCACHEDCLOUD_PASSWORD"] }
  end
end

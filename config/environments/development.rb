Linguazone::Application.configure do
  config.cache_classes = false
  config.whiny_nils = true
  config.action_controller.perform_caching = false
  config.action_mailer.raise_delivery_errors = true
  config.action_mailer.perform_deliveries = false
  
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['S3_BUCKET_NAME'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }
  
  config.serve_static_assets = true
  config.active_support.deprecation = :notify
  config.action_mailer.default_url_options = { :host => "localhost:3000" }
end

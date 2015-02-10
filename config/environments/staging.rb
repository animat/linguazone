Linguazone::Application.configure do

  
  config.log_level = ENV['LOG_LEVEL'] ? ENV['LOG_LEVEL'].to_sym : ('info').to_sym
  config.consider_all_requests_local = ENV['CONSIDER_REQUESTS_LOCAL']
  
  config.cache_classes = false
  
  config.paperclip_defaults = {
    :storage => :s3,
    :s3_credentials => {
      :bucket => ENV['S3_BUCKET_NAME'],
      :access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    }
  }

  config.action_controller.perform_caching             = true
  config.action_view.cache_template_loading            = true
  config.action_mailer.perform_deliveries = false
  config.action_mailer.default_url_options = { :host => "lz-staging.herokuapp.com" }
end


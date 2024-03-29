# Put this in config/application.rb
require File.expand_path('../boot', __FILE__)

require "thread"
require 'rails/all'

Bundler.require(:default, Rails.env) if defined?(Bundler)

module Linguazone
  class Application < Rails::Application
    config.assets.enabled = true
    config.filter_parameters << :password << :password_confirmation
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Add additional load paths for your own custom dirs
    # config.load_paths += %W( #{RAILS_ROOT}/extras )

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Skip frameworks you're not going to use. To use Rails without a database,
    # you must remove the Active Record framework.
    # config.frameworks -= [ :active_record, :active_resource, :action_mailer ]

    # Activate observers that should always be running
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names.
    config.time_zone = 'Eastern Time (US & Canada)'

    config.action_mailer.default_url_options = { :host => "linguazone.com" }
    
    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}')]
    # config.i18n.default_locale = :de

    # JOYENT DEPLOYMENT: Unpacked gems to vendor/gems, now adding this directory to load path
    #   followed tutorial at http://wiki.joyent.com/shared:kb:installing-rails
    config.autoload_paths += Dir["#{Rails.root}/vendor/gems/**"].map do |dir|
      File.directory?(lib = "#{dir}/lib") ? lib : dir
    end
    
    config.encoding = "UTF-8"
  end
end


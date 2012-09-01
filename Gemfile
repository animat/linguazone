source 'http://rubygems.org'

gem 'rdoc'
gem 'rails3-jquery-autocomplete'
gem 'rails', '3.1.0'
gem "aws-s3", '0.6.2', :require => "aws/s3"
gem "authlogic"
gem "meta_search", ">= 1.1.0.pre"
gem "declarative_authorization"
gem "rexml-expansion-fix"
gem "whenever"
gem 'paperclip', '2.3.6'
gem 'simple_form'
gem 'dynamic_form'
gem 'pg'
gem 'seed-fu'
gem 'activeadmin'
gem 'kaminari'
gem 'happymapper'
gem 'swf_fu', '>= 2.0'
gem "airbrake"
gem "omniauth"
gem "omniauth-twitter"
gem "omniauth-openid"
gem "omniauth-facebook"
gem "spreadsheet"

# Rails 3.1 - Asset Pipeline
gem 'json'
gem 'sass-rails'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'

gem "rack-timeout"

group :production do
  gem 'therubyracer', '0.9.4'
	gem "SystemTimer", :require => "system_timer", :platforms => :ruby_18
end

group :development, :test do
  gem 'spork',           '~> 0.9.0.rc9'
  gem 'guard'
  gem 'guard-spork'
  gem 'guard-rspec'
  gem 'rack-test'
  gem 'rspec-rails'
  gem "launchy"
  gem "database_cleaner"
  gem "ruby-debug", :platforms => [:mri_18]
  gem "ruby-debug19", :platforms => [:mri_19]
  gem "factory_girl"
  gem "factory_girl_rails", "1.1.0"
  gem 'pry-rails'
  gem 'mysql2'
  gem 'bullet'
end

group :test do
  gem "cucumber-rails"
  gem "mocha"
  gem "capybara"
  gem "shoulda"
  gem "timecop"
  gem 'email_spec'
  gem 'action_mailer_cache_delivery'
end

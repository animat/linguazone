source 'http://rubygems.org'

gem 'rdoc'
gem 'rails3-jquery-autocomplete'
gem 'rails', '3.1.0'
gem "aws-s3", '0.6.2', :require => "aws/s3"
gem "authlogic"
gem "meta_search", ">= 1.1.0.pre"
gem "declarative_authorization"
gem "rexml-expansion-fix"
gem "rabl"
gem "whenever"
gem 'paperclip'
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
gem 'nokogiri'
gem 'flickraw'

# Rails 3.1 - Asset Pipeline
gem 'json'
gem 'sass-rails'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails'
gem 'fine-uploader-rails', '~> 3.2'
gem "qqfileuploader"

gem "rack-timeout"
gem "ejs"

group :production do
  gem "SystemTimer", :require => "system_timer", :platforms => :ruby_18
end

group :development, :cucumber, :test do
  gem 'spork',           '~> 0.9.0.rc9'
  gem 'guard'
  gem 'guard-spork'
  gem "launchy"
  gem "database_cleaner"
  gem "ruby-debug", :platforms => [:mri_18]
  gem "ruby-debug19", :platforms => [:mri_19]
  gem 'pry-rails'
  gem 'mysql2'
  gem "jasmine-rails"
end

group :test, :cucumber do
  gem 'webmock'
  gem 'vcr'
  gem 'guard-rspec'
  gem 'rack-test'
  gem 'rspec-rails'
  gem "factory_girl"
  gem "factory_girl_rails", "1.1.0"
  gem 'capybara-webkit', '0.12.0'
  gem "guard-jasmine-headless-webkit"
  gem "cucumber-rails", :require => false
  gem "mocha"
  gem "capybara"
  gem "shoulda"
  gem "timecop"
  gem 'email_spec'
end

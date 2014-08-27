source 'http://rubygems.org'

ruby "1.9.3"

gem 'rdoc'
gem 'rails3-jquery-autocomplete', "~> 1.0.10"
gem 'rails', '~> 3.2.11'
#gem "aws-s3", '0.6.2', :require => "aws/s3"
#gem 'paperclip', "~> 2.8"
gem "aws-sdk"
gem 'paperclip'

gem "authlogic", "3.2.0"
gem 'bcrypt-ruby', "3.0.1"
gem 'scrypt', "1.0.2"
gem "meta_search", ">= 1.1.0.pre"
gem "declarative_authorization"
gem "rexml-expansion-fix"
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
gem "nokogiri", "1.5.10"
gem 'flickraw'
gem "select2-rails"
gem "rabl"

# Rails 3.1 - Asset Pipeline
gem 'json'
gem 'sass-rails'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails', "~> 2.1"
gem 'fine-uploader-rails', '~> 3.2'
gem "qqfileuploader", :git => "https://github.com/ignu/qqfileuploader.git"
gem "rack-timeout"
gem "ejs"

group :production do
  gem "unicorn"
  gem "newrelic_rpm"
  gem 'therubyracer'
  gem "rails_12factor"
  gem "dalli"
end
#
group :development, :cucumber, :test do
  gem 'spork',           '~> 0.9.0.rc9'
#  gem 'guard'
#  gem 'guard-spork'
#  gem 'guard-rspec'
  gem "launchy"
  gem "jasmine-rails"
  gem "database_cleaner"
  gem "debugger"
  gem 'pry-rails'
  gem 'bullet', "2.3.1"
  gem 'xray-rails'
end

group :production, :test, :cucumber do
  gem "SystemTimer", :require => "system_timer", :platforms => :ruby_18
end

group :test, :cucumber do
  gem 'webmock'
  gem 'vcr'
  gem 'guard-rspec'
  gem 'rack-test'
  gem 'rspec-rails'
  gem "factory_girl"
  gem "factory_girl_rails", "1.1.0", :require => false
  gem "guard-jasmine-headless-webkit"
  gem "cucumber-rails", "~> 1.4.0", :require => false
  gem "rubyzip", "0.9.9"
  gem "selenium-webdriver"
  gem "mocha"
  gem "capybara", "1.1.4"
  gem "shoulda"
  gem "timecop", "0.5.0"
  gem 'email_spec'
end
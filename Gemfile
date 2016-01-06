source 'http://rubygems.org'

ruby "1.9.3"

gem 'rdoc'
gem 'rails3-jquery-autocomplete', "~> 1.0.10"
gem 'rails', '~> 3.2.11'
gem "aws-sdk"
gem "authlogic", "3.2.0"
gem 'bcrypt-ruby', "3.0.1"
gem 'scrypt', "1.0.2"
gem "meta_search", ">= 1.1.0.pre"
gem "declarative_authorization"
gem "rexml-expansion-fix"
gem 'paperclip'
gem "rmagick"
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
gem "transloadit-rails"
gem "nested_form_fields"
gem "youtube_addy"
gem "rack-cors", :require => "rack/cors"

# Rails 3.1 - Asset Pipeline
gem 'json'
gem 'sass-rails'
gem 'coffee-script'
gem 'uglifier'
gem 'jquery-rails', "~> 2.1"
gem "rack-timeout"

group :production do
  gem "unicorn"
  gem "newrelic_rpm"
  gem 'therubyracer'
  gem "rails_12factor"
  #gem "dalli" # TODO: Temporarily removed while loading errors persist 9/14
	gem "SystemTimer", :require => "system_timer", :platforms => :ruby_18
end
#
group :development, :test do
  gem 'spork',           '~> 0.9.0.rc9'
#  gem 'guard'
#  gem 'guard-spork'
#  gem 'guard-rspec'
  gem 'rack-test'
  gem 'rspec-rails'
  gem "launchy"
  gem "database_cleaner"
  #gem "ruby-debug", :platforms => [:mri_18]
  #gem "ruby-debug19", :platforms => [:mri_19]
  gem "debugger"
  #gem "factory_girl"
  gem "factory_girl_rails", "1.1.0"
  gem 'pry-rails'
  gem 'bullet', "2.3.1"
  gem "dotenv-rails"
end
#
group :test do
  gem "cucumber-rails", "~> 1.4.0"
  gem "rubyzip", "0.9.9"
  gem "selenium-webdriver"
#  gem "mocha"
  gem "capybara", "1.1.4"
#  gem "shoulda"
  gem "timecop", "0.5.0"
  gem 'email_spec'
end

source 'http://rubygems.org'

gem 'mysql'
gem 'rails', '2.3.5'
gem 'rack',  '1.0.1'
gem 'SystemTimer'

gem "aws-s3", '0.6.2', :require => "aws/s3"
gem "authlogic"
gem "searchlogic"
gem "declarative_authorization"
gem "will_paginate"
gem "rexml-expansion-fix"
gem "whenever"
gem 'paperclip', '2.3.6'

group :development, :test do
  gem 'spork',           '~> 0.9.0.rc'
  gem 'rspec',           '<2.0',            :require => 'spec'
  gem 'rspec-rails',     '<2.0', :require => 'spec/rails'
  gem "launchy",         "0.3.7"
  gem "database_cleaner"
  gem "ruby-debug", :platforms => [:mri_18]
  gem "ruby-debug19", :platforms => [:mri_19]
end

group :test do
  gem "mocha"
  gem "capybara"
  gem "cucumber-rails"
  gem "factory_girl", '1.2.3'
  gem "shoulda"
  gem "timecop"
end

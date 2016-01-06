require 'rubygems'
require 'spork'
require 'factory_girl_rails'
FactoryGirl.find_definitions 

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'ruby-debug'

  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

  RSpec.configure do |config|
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.fixture_path = Rails.root + '/spec/fixtures/'

    config.mock_with :mocha

    config.before(:each) do
    end
  end
end

Spork.each_run do
end

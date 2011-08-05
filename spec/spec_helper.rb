require 'rubygems'
require 'spork'

Spork.prefork do


  # This file is copied to ~/spec when you run 'ruby script/generate rspec'
  # from the project root directory.
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path(File.join(File.dirname(__FILE__),'..','config','environment'))
  require 'spec'
  require 'spec/autorun'
  require 'spec/rails'

  require 'factory_girl'
  require 'ruby-debug'

  Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

  Spec::Runner.configure do |config|
    config.use_transactional_fixtures = true
    config.use_instantiated_fixtures  = false
    config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

    config.mock_with :mocha

    config.before(:each) do
    end
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.
  load RAILS_ROOT + '/spec/factories.rb'
end


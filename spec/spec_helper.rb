require 'rubygems'
require 'spork'
require 'factory_girl'

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

VCR.configure do |c|
  c.ignore_request do |request|
    #TODO: not really sure why jenkins is doing this.
    URI(request.uri).host == '127.0.0.1'
  end

  c.cassette_library_dir = 'fixtures/vcr_cassettes'
  c.hook_into :webmock # or :fakeweb
end

# XML matcher stolen from http://johnleach.co.uk/words/585/testing-xml-with-rspec-xpath-and-libxml
require 'libxml'
RSpec::Matchers.define :have_xml do |xpath, text|
  match do |body|
    parser = LibXML::XML::Parser.string body
    doc = parser.parse
    nodes = doc.find(xpath)
    nodes.empty?.should be_false
    if text
      nodes.each do |node|
        node.content.should == text
      end
    end
    true
  end

  failure_message_for_should do |body|
    "expected to find xml tag #{xpath} in:\n#{body}"
  end

  failure_message_for_should_not do |response|
    "expected not to find xml tag #{xpath} in:\n#{body}"
  end

  description do
    "have xml tag #{xpath}"
  end
end

Spork.each_run do
end

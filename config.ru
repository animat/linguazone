# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment',  __FILE__)
run Linguazone::Application

require 'rack/cors'
use Rack::Cors do
  allow do
    origins '*'

    resource '/cors',
      :headers => :any,
      :methods => [:post],
      :credentials => true,
      :max_age => 0

    resource '*',
      :headers => :any,
      :methods => [:get, :post, :delete, :put, :options, :head],
      :max_age => 0
  end
end
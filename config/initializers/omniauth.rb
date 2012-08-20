#require 'openid/store/filesystem'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :twitter, '1sV6GugcvVvhzhBt0WaWA', 'INmFgq9pxNJBUOok1L8f0xEn8GBflOxPovq4hIFH6E'
end
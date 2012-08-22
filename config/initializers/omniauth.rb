Rails.application.config.middleware.use OmniAuth::Builder do
  require "openid/fetchers"
  OpenID.fetcher.ca_file = "#{Rails.root}/config/ca-bundle.crt"
  
  provider :open_id, :name => 'google', :identifier => 'https://www.google.com/accounts/o8/id'
  provider :twitter, '1sV6GugcvVvhzhBt0WaWA', 'INmFgq9pxNJBUOok1L8f0xEn8GBflOxPovq4hIFH6E'
  
  if Rails.env == 'development' || Rails.env == 'test'
    provider :facebook, '105246569626185', '2582bd07f843b78db0110c6bffb33e4b'
  else
    provider :facebook, '412321485490665', 'a726122e38a1eb5fe1fbaf037bdc3509'
  end
end
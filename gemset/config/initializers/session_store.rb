# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_gemset_session',
  :secret      => 'ec431cfd73511206b0636f15ba55c4cd8e7a4d6e195012d26afa84810bb35f4ec8ba9569e120c9ea6ca34ee23d5ac85ba41fff315a8bb901a852342ec9362254'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

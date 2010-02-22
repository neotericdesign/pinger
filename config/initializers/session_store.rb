# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_pinger_session',
  :secret      => '3eb03571bc52a1e8c862dd6ce23b2de2c050680ba750e7c2c9dc7fe6cb7149c301317bf5cabd68c39ade8c8b2ccb21d3e117aab642f263262f3ce303ee72baf3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

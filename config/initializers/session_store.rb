# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_parrot_session',
  :secret      => '0a52a9b0d8f5e6adfdf2b45ffa6fc176f87cc212287a302ebb5e95064f03e0dd4a49251974afa170ba87685a6aec665c28af79e2766325f8378c975cc52a77ac'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

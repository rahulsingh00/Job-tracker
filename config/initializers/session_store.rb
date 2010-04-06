# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_job_tracker_session',
  :secret      => '8d0fd20e6915ad90df5cc61fc6a68f63beae3035bcd7843c887a55c416e854fa429f3c0d27b437c514769a3c2b2c586a3c7208aef0da5abb8028c9ecd40fc505'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

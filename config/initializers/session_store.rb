# Be sure to restart your server when you modify this file.

Appointment::Application.config.session_store :cookie_store, key: '_appointment_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Appointment::Application.config.session_store :active_record_store

 Appointment::Application.config.session_store ActionDispatch::Session::CacheStore, :expire_after => 10.hours


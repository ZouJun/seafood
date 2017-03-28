require 'sidekiq'
# require 'sidekiq-status'
require 'sidekiq/web'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379' }
end

Sidekiq::Web.use(Rack::Auth::Basic) do |user, password|
  [user, password] == ["sidekiqadmin", "123456"]
end
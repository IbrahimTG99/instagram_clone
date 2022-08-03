require 'sidekiq'
require 'pg'
require_relative '../jobs' # here is my job locates

# If your client is single-threaded, we just need a single connection in our Redis connection pool
Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/0', namespace: 'analytic_serv', size: 5 }
end

# Sidekiq server is multi-threaded so our Redis connection pool size defaults to concurrency (-c)
Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/0', namespace: 'analytic_serv' }
end

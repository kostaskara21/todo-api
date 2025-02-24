# config/initializers/redis.rb
#REDIS = Redis.new(host: 'localhost', port: 6379, db: 0)
REDIS = Redis.new(url: ENV['REDIS_URL'] || 'redis://localhost:6379')
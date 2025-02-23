# config/initializers/redis.rb
REDIS = Redis.new(host: 'localhost', port: 6379, db: 0)

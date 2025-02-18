source "https://rubygems.org"

ruby "3.0.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.1.5", ">= 7.1.5.1"

# Use sqlite3 as the database for Active Record
gem "sqlite3", ">= 1.4"


gem "puma", ">= 5.0"


gem "tzinfo-data", platforms: %i[ mswin mswin64 mingw x64_mingw jruby ]


gem "bootsnap", require: false


# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'jwt'

group :development, :test do
  gem 'rspec-rails', '~> 4.0'
  gem "debug", platforms: %i[ mri mswin mswin64 mingw x64_mingw ]
end

group :test do
  gem 'factory_bot_rails', '~> 4.0'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'faker'
  gem 'database_cleaner'
end

group :development do
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end


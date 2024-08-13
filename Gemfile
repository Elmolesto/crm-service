# frozen_string_literal: true

source "https://rubygems.org"

ruby "3.1.2"
gem "rails", "~> 7.1.3", ">= 7.1.3.2"

gem "bootsnap", require: false
gem "devise"
gem "devise-jwt"
gem "image_processing", "~> 1.2"
gem "jbuilder"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "pundit"

# Use Active Model has_secure_password
# [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS),
# making cross-origin Ajax possible
# gem "rack-cors"

group :development, :test do
  gem "debug", platforms: %i[mri mswin mswin64 mingw x64_mingw]
  gem "factory_bot_rails"
  gem "rubocop", "~> 1.44", require: false
  gem "rubocop-performance"
  gem "rubocop-rails"
end

group :development do
  gem "error_highlight", ">= 0.4.0", platforms: [:ruby]
  gem "overcommit"
end

group :test do
  gem "database_cleaner-active_record"
  gem "faker"
  gem "rspec-rails"
  gem "shoulda-matchers"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[mswin mswin64 mingw x64_mingw jruby]

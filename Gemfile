source "https://rubygems.org"
ruby "2.3.0"

gem "rails", "4.2.5"
# Postgres as db
gem "pg"
gem "sass-rails", "~> 5.0"
gem "materialize-sass"
gem "slim-rails"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.1.0"
gem "jquery-rails"
gem "jquery-ui-rails"
gem "zeroclipboard-rails"
gem "turbolinks"
gem "jwt"
gem "devise", "~> 3.5", ">= 3.5.6"
gem "faker"
gem "active_model_serializers", "~> 0.10.0.rc4", github: "rails-api/active_model_serializers"
gem 'kaminari', '~> 0.16.1'
gem "sdoc", "~> 0.4.0", group: :doc
gem "geocoder", "~> 1.3.1"
gem "rack-cors"

gem "rails_12factor", group: :production

gem "shoulda-matchers", group: :test
# gem "factory_girl_rails", "~> 4.0"

# Use ActiveModel has_secure_password
# gem "bcrypt", "~> 3.1.7"

# Puma as development server.
gem "puma"

group :development, :test do
  # Call "byebug" anywhere in the code to stop execution and get a debugger console
  gem "rspec-rails"
  gem "byebug"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
  gem "rack-livereload"
  gem "guard"
  gem "guard-livereload", "~> 2.4", require: false

  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem "spring"
end

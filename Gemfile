source 'https://rubygems.org'

gem 'rails', '3.2.11'

# Authentication
gem 'devise'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'
gem "haml-rails"

# Gems used only for assets and not required
# in production environments by default.
group :assets do

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'sass-rails'
  gem 'simple_form'
  gem 'bootstrap-sass'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# We should discuss this on next meeting
group :linux_development do
  gem 'rb-inotify', '~> 0.8.8' # File watcher
  gem 'libnotify' # Guard notifications for Linux
end

group :mac_development do
  gem 'rb-fsevent' # File watcher
  gem 'growl' # Guard notifications for OS X
end

group :test, :development do
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-test'
  gem 'spork'
  gem 'spork-testunit'
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'

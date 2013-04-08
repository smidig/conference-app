source 'https://rubygems.org'
ruby "1.9.3"

gem 'rails', '3.2.13'
gem 'haml-rails'
gem 'paperclip'
gem 'aws-sdk'
gem 'jquery-rails'
gem 'simple_form'
gem 'rdiscount'
gem 'devise'

# Gems used only for assets and not required
# in production environments by default.
group :assets do

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'sass-rails'
  gem 'bootstrap-sass'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'pg'
end

group :linux_development do
  gem 'rb-inotify', '~> 0.9' # File watcher
  gem 'libnotify' # Guard notifications for Linux
end

group :mac_development do
  gem 'rb-fsevent' # File watcher
  gem 'growl' # Guard notifications for OS X
end

group :test, :development do
  gem 'sqlite3'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-test'
  gem 'guard-migrate'
  gem 'spork'
  gem 'spork-testunit'
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
end

group :test do
  gem 'webmock'
  gem 'cucumber-rails'
  gem 'database_cleaner'
end

# To use debugger
# gem 'debugger'

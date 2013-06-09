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
gem 'csv_shaper'
gem 'acts_as_votable', '~> 0.5.0'

# Gems used only for assets and not required
# in production environments by default.
group :assets do

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'sass-rails'
  gem 'bootstrap-sass', '~> 2.3.1.3'
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

group :tools do
  gem 'guard-test'
end

group :development do
  gem 'sqlite3'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'guard-migrate'
  gem 'spork'
  gem 'spork-testunit'
  gem 'database_cleaner'
end

group :test do
  gem 'sqlite3'
  gem 'webmock'
  gem 'mocha'
  gem 'rspec-rails'
  gem 'factory_girl_rails', :require => false
  gem 'cucumber-rails'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'webrat'
end

# To use debugger
# gem 'debugger'

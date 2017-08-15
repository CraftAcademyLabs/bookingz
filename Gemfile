source 'https://rubygems.org'

ruby '2.4.0'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1'
gem 'pg', '~> 0.18'
gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'jquery-rails'
gem 'turbolinks', '~> 5'
gem 'jbuilder', '~> 2.5'
gem 'redis', '~> 3.0'
gem 'config'
gem 'high_voltage'
gem 'rack-cors', require: 'rack/cors'
gem 'redcarpet'

# UI
gem 'haml-rails'
gem 'materialize-sass'
gem 'material_icons'
gem 'rails-i18n', '~> 5.0.0'

# Functionality libraries
gem 'devise', '~> 4.3'
gem 'devise-i18n'
gem 'acts_as_bookable', git: 'https://github.com/CraftAcademy/acts_as_bookable',
                        branch: 'master'

# Date navigation
gem 'datejs-rails'

# Geolocation
gem 'geocoder'


group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'launchy'
  gem 'guard-rspec'
  gem 'guard-cucumber'
  gem 'guard-livereload'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'poltergeist'
  gem 'phantomjs', require: 'phantomjs/poltergeist'
  gem 'timecop'
  gem 'simplecov', git: 'https://github.com/colszowka/simplecov'
  gem 'coveralls', require: false
  gem 'railroady'
  gem 'redis_test'
end

group :development do
  gem 'capistrano', '~> 3.8', '>= 3.8.2'
  gem 'capistrano-bundler', '~> 1.2'
  gem 'capistrano-rails', '~> 1.3'
  gem 'capistrano-env-config'
  gem 'capistrano-rbenv', '~> 2.1', '>= 2.1.1'
  gem 'capistrano3-puma', '~> 3.1', '>= 3.1.1'
  gem 'listen', '~> 3.0.5'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'spring'
  # gem 'web-console'
end

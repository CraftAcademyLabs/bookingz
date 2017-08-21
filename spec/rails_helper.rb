# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require 'timecop'
require 'paperclip/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Settings.mode = :daily_view

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Shoulda::Matchers::ActiveRecord, type: :model
  config.include FactoryGirl::Syntax::Methods
  config.include ResponseJSON, type: :request
  config.include Paperclip::Shoulda::Matchers

  config.before(:each) do
    Aws.config[:s3] = {stub_responses: true}
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end


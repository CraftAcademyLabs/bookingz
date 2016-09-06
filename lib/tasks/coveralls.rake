if Rails.env.development? || Rails.env.test?
  require 'rspec/core/rake_task'
  require 'cucumber/rake/task'
  require 'coveralls/rake/task'

  Coveralls::RakeTask.new
  task test_with_coveralls: [:spec, :cucumber, 'coveralls:push']
end

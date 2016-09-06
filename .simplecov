SimpleCov.start 'rails' do
  add_filter 'lib/tasks/cucumber.rake'
  add_filter 'app/mailer'
  add_filter 'app/channels'
  add_filter 'app/job'
end

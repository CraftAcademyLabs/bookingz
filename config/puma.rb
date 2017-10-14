# threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
# threads threads_count, threads_count
#
# port ENV.fetch('PORT') { 3000 }
# environment ENV.fetch('RAILS_ENV') { 'production' }
#
#
# if ENV.fetch('RAILS_ENV') == 'production'
#   bind 'unix:/var/www/bookingz/current/tmp/bookingz-puma.sock'
#   daemonize true
#   pidfile '/var/www/bookingz/current/tmp/pids/bookingz-puma.pid'
# end
#
#
# plugin :tmp_restart


workers Integer(ENV['WEB_CONCURRENCY'] || 2)
threads_count = Integer(ENV['RAILS_MAX_THREADS'] || 5)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || 3000
environment ENV['RACK_ENV'] || 'development'

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
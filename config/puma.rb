threads_count = ENV.fetch("RAILS_MAX_THREADS") { 5 }.to_i
threads threads_count, threads_count

port        ENV.fetch("PORT") { 3000 }
environment ENV.fetch("RAILS_ENV") { 'production' }

#bind 'unix:/var/www/bookingz/current/tmp/bookingz-puma.sock'
#daemonize true
#pidfile '/var/www/bookingz/current/tmp/pids/bookingz-puma.pid'

plugin :tmp_restart

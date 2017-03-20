namespace :admin do
  task :unassign => [ :environment ] do
    desc 'Unassign all users from Facilities'
    User.all.each {|u| u.facility = nil; u.save}
  end
end

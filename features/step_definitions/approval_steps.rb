Given(/^there are no pending approval requests$/) do
  User.where(approved: false).each do |user|
    user.destroy
  end
end

Given(/^I click on "([^"]*)" for user "([^"]*)"$/) do |value, email|
  sleep 1
  user = User.find_by(email: email)
  within "#row-#{user.id}" do
    click_link_or_button value
  end
end

Given(/^I try to approve "([^"]*)"$/) do |email|
  admin_user = FactoryGirl.create(:user, email: 'superadmin@superadmin.co', password: 'admin_password', superadmin: true)
  user = User.find_by(email: email)
  #post approvals_users_path(id: user.id)

  @session = ActionDispatch::Integration::Session.new(Rails.application)
  @session.post(user_session_path, params: {user: {email: admin_user.email, password: 'admin_password', remember_me: '0'}})
  @session.post(approvals_users_path(locale: :en), params: {id: user.id})
  @session.follow_redirect!

end

Given(/^the following user is pending approval$/) do |table|
  table.hashes.each do |user|
    FactoryGirl.create(:user, user.merge(approved: false))
  end
end

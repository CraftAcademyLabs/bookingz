FactoryGirl.define do
  factory :user do
    email 'random@random.com'
    password 'password'
    password_confirmation 'password'
  end
end

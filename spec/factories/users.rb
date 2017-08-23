FactoryGirl.define do
  factory :user do
    email { Faker::Internet.email }
    password 'password'
    approved true
  end
end

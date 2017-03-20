FactoryGirl.define do
  factory :user do
    email 'random@random.com'
    password 'password'
    approved true
  end
end

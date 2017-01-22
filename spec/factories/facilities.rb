FactoryGirl.define do
  factory :facility do
    name 'MyString'
    code { [*('a'..'z'),*('0'..'9')].sample(4).join }
  end
end

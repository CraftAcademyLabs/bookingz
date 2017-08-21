FactoryGirl.define do
  factory :facility do
    name 'MyString'
    code { [*('a'..'z'), *('0'..'9')].sample(4).join }
    attachment { File.new("#{Rails.root}/spec/fixtures/my_cat.png") }
  end
end

FactoryBot.define do 
  factory :user do 
    email { "#{Faker::Alphanumeric.unique.alphanumeric(number: 8)}@eaxmple.com".downcase }
    password { "password" }
  end
end
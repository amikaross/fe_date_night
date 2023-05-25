FactoryBot.define do 
  factory :favorite do 
    google_id { Faker::Alphanumeric.unique.alphanumeric(number: 8) }
    user_id { create(:user).id }
    name { Faker::Lorem.word }
  end
end
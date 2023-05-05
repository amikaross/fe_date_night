require 'date'

FactoryBot.define do 
  factory :appointment do 
    name { Faker::Lorem.sentence(word_count: 3) }
    place_id { 'ChIJl7-Ogyd5bIcRTgzca2cfXmw' }
    recurring { false }
    time { Time.now }
    date { Date.today }
    notes { Faker::Lorem.sentence(word_count: 8) }
  end
end
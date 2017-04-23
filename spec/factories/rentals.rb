FactoryGirl.define do
  factory :rental do
    name { Faker::Lorem.word }
    daily_rate { 100 }
  end
end

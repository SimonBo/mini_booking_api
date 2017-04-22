FactoryGirl.define do
  factory :rental do
    name { Faker::Lorem.word }
    daily_rate { Faker::Number.between(1, 1000) }
  end
end

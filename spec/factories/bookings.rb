FactoryGirl.define do
  factory :booking do
    user
    start_at Time.current
    end_at 1.day.from_now
    client_email "my@email.com"
    price 100
    rental
  end
end

FactoryGirl.define do
  factory :booking do
    start_at Time.current
    end_at 1.day.from_now
    client_email "MyString"
    price 100
    rental
  end
end

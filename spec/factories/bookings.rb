FactoryGirl.define do
  factory :booking do
    start_at Time.current
    end_at 1.day.from_now
    client_email "MyString"
    price 1
    rental
  end
end

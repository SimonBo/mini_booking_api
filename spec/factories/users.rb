FactoryGirl.define do
  factory :user do
    username {Faker::Name.first_name + rand(1000).to_s}
    password_digest "MyString"
  end
end

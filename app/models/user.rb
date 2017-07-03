class User < ApplicationRecord
 has_secure_password
 validates :username, presence: true, uniqueness: true

 has_many :bookings
 has_many :rental_ratings
end

class Rental < ApplicationRecord
  has_many :bookings
  has_many :rental_ratings

  validates :name, :daily_rate, presence: true
end

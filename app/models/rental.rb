class Rental < ApplicationRecord
  validates :name, :daily_rate, presence: true
end

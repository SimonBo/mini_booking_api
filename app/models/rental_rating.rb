class RentalRating < ApplicationRecord
  belongs_to :user
  belongs_to :rental

  validates :user_id, :rental_id, :stars, presence: true
end

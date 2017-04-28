class Booking < ApplicationRecord
  belongs_to :rental

  validates :start_at, :end_at, :client_email, :price, :rental_id, presence: true
  validate :booking_for_at_least_one_night
  validate :price_must_be_valid
  validate :bookings_dont_overlap

  private

  def booking_for_at_least_one_night
    if start_at and end_at and length_of_stay <= 0
      errors.add(:base, 'the reservation is only possible for at least one night stay')
    end
  end

  def price_must_be_valid
    if price and length_of_stay and rental
      unless price == length_of_stay * rental.daily_rate
        errors.add(:price, 'is not correct')
      end
    end
  end

  def bookings_dont_overlap
    booking_count = self.new_record? ? 0 : 1
    if rental and date_range and rental.bookings.where(start_at: date_range).or(rental.bookings.where(end_at: date_range)).count > booking_count
      errors.add(:end_at, 'has already been booked for that time period')
    end
  end

  def date_range
    return nil if start_at.nil? or end_at.nil?
    start_at..end_at
  end

  def length_of_stay
    return nil if start_at.nil? or end_at.nil?
    (end_at.to_date - start_at.to_date).to_i
  end
end

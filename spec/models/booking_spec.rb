require 'rails_helper'

RSpec.describe Booking, type: :model do
  it { should validate_presence_of(:start_at) }
  it { should validate_presence_of(:end_at) }
  it { should validate_presence_of(:client_email) }
  it { should validate_presence_of(:price) }
  it { should validate_presence_of(:rental_id) }

  it 'has a valid factory' do
    booking = build :booking
    expect(booking).to be_valid
  end

  describe '#booking_for_at_least_one_night' do
    it 'is valid if the booking is for at least one night' do
      rental = create :rental, daily_rate: 100
      booking = build :booking, start_at: Time.current, end_at: 1.day.from_now, price: 100, rental: rental
      expect(booking).to be_valid
    end

    it 'is valid if the booking start_at and end_at are on the same day' do
      booking = build :booking, start_at: Time.current.beginning_of_day, end_at: Time.current.beginning_of_day + 2.hours
      expect(booking).not_to be_valid
    end
  end

  describe '#correct_price' do
    it 'is invalid if the price doesnt match the length of stay' do
      rental = create :rental, daily_rate: 100
      booking = build :booking, start_at: Time.current, end_at: 1.day.from_now, price: 5000, rental: rental
      expect(booking).not_to be_valid
      expect(booking.errors[:price].size).to eq 1
    end

    it 'is valid if the price is correct' do
      rental = create :rental, daily_rate: 100
      booking = build :booking, start_at: Time.current, end_at: 1.day.from_now, price: 100, rental: rental
      expect(booking).to be_valid
    end
  end

  describe '#bookings_dont_overlap' do
    it 'is invalid if there is another booking with dates overlaping with the new booking for given rental' do
      rental = create :rental, daily_rate: 100
      old_booking = create :booking, rental: rental, start_at: 10.days.ago, end_at: 4.days.ago, price: 600
      new_booking = build :booking, rental: rental, start_at: 5.days.ago, end_at: 1.day.ago, price: 400
      expect(new_booking).not_to be_valid
      expect(new_booking.errors[:end_at].size).to eq 1
    end

    it 'is valid if the dates dont overlap with other bookings of given rental' do
      rental = create :rental, daily_rate: 100
      old_booking = create :booking, rental: rental, start_at: 10.days.ago, end_at: 4.days.ago, price: 600
      new_booking = build :booking, rental: rental, start_at: 3.days.ago, end_at: 1.day.ago, price: 200
      expect(new_booking).to be_valid
    end
  end
end

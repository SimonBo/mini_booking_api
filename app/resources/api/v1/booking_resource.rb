class Api::V1::BookingResource < Api::V1::ApplicationResource
  attributes :start_at, :end_at, :client_email, :price
  has_one :rental

  model_name 'Booking'
end

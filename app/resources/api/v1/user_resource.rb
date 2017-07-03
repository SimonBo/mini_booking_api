class Api::V1::UserResource < Api::V1::ApplicationResource
  attributes :username

  has_many :bookings

  model_name 'User'
end

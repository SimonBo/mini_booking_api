class Api::V1::RentalRatingResource < Api::V1::ApplicationResource
    attributes :stars

    has_one :user
    has_one :rental

    model_name 'RentalRating'

    filters :user_id, :rental_id, :id
end

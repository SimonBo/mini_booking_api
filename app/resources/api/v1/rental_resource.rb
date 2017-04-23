class Api::V1::RentalResource < Api::V1::ApplicationResource
    attributes :name, :daily_rate

    model_name 'Rental'
end

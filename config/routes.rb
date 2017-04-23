Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :rentals
      jsonapi_resources :bookings
    end
  end
end

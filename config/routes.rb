Rails.application.routes.draw do
  post 'login', to: 'sessions#login'
  namespace :api do
    namespace :v1 do
      jsonapi_resources :rentals
      jsonapi_resources :rental_ratings
      jsonapi_resources :bookings
      resources :users, only: [:index, :create]
    end
  end
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  namespace :api, format: :json do
    namespace :v1 do
      resources :users, only: [:create] do
        collection do
          post :find_bookings
        end
      end
      resources :bookings, only: [:create] do
        collection do
          post :available_tee_times
          post :booked_time_slots
        end
        member do
          get :cancel_booking
        end
      end 
    end
  end
end

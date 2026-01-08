Rails.application.routes.draw do
  # Web authentication routes (for browser-based users)
  resource :session
  resources :passwords, param: :token

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "bus_schedules#index"

  # API routes (for SPA/mobile clients with JWT authentication)
  namespace :api do
    # Authentication endpoints
    post "auth/login", to: "auth#login"
    post "auth/refresh", to: "auth#refresh"
    get "auth/me", to: "auth#me"

    # Registration endpoint
    post "registrations", to: "registrations#create"

    # Resource endpoints (require JWT authentication)
    resources :buses
    resources :bus_schedules do
      collection do
        get "by_route"
      end
    end
    resources :routes
    resources :bookings
    resources :payments
    resources :provinces
  end
end

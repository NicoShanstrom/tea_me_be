Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      resources :customers, only: [:create, :destroy] do
        resources :subscriptions, only: [:index], module: :customers
      end
      resources :subscriptions, only: [:create, :destroy, :show]
      resources :teas, only: [:create, :destroy]
    end
  end
end

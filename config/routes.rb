Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check # standard:disable all

  # Defines the root path route ("/")
  root "domains#index"

  resources :domains, param: :name, shallow: true do
    scope module: :domains do
      resources :resources
    end
  end

  # Administrate
  namespace :admin do
    resources :domains
    resources :configuration, only: [:index, :show, :edit, :update]
    resources :features, only: [:index]
    resources :jobs, only: [:index]

    scope :engines do
      mount Flipper::UI.app(Flipper) => "/flipper"
      mount MissionControl::Jobs::Engine, at: "/mission_control"
    end

    root to: "domains#index"
  end

  resources :configuration, only: [:new, :create]
end

# typed: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :domains, only: [:new, :destroy], param: :host do
    member do
      get '/', to: 'domains#dns'
      get 'dns'
      get 'dns_frame_records'
      get 'email'
      get 'links'
      get 'settings'
      post 'add_record'
      post 'destroy_record'
      post 'update_record'
    end
    collection do
      get '/', to: redirect("/")
      get 'request', to: 'domains#request_domain'
      post 'new'
    end
  end

  get 'users/auth'
  get 'users/login'
  get 'users/logout'
  get 'users/new'

  # Defines the root path route ("/")
  root "domains#index"
end

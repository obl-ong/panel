# typed: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  get 'domains/request', to: 'domains#request_domain'
  
  resources :domains, param: :host, :except => [:new] do
    member do
      get '/', to: 'records#index'
      get 'email'
      get 'links'
      get 'settings'
      get 'show', as: "show"
      patch 'transfer'
      resources :records
    end
  end

  get 'admin', to: "admin#index"
  get 'admin/users', to: "admin#users"
  get 'admin/domains', to: "admin#domains"
  get 'admin/users/:id/domains', to: "admin#users_domains", as: 'admin_users_domains'

  get 'users/register'
  post 'users/create'
  get 'users/email_verification'
  post 'users/verify_email'
  patch 'users/update'
  
  get 'settings', to: "users#settings"

  get 'auth/create_key'
  patch 'auth/add_key'
  delete 'auth/destroy_key'
  
  get 'auth/login'
  get 'auth/logout'
  # need to send request body, made it POST
  post 'auth/verify_key'
  
  get 'auth/unsupported'

  # Defines the root path route ("/")
  root "domains#index"
end

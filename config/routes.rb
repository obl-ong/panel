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

  get 'users/register'
  post 'users/create'
  get 'users/logout'
  
  # this should be POST, but because I can't redirect to POST, it must be GET
  get 'auth/blank_key'
  get 'auth/sign_key'
  patch 'auth/cut_key'
  
  get 'auth/login'
  # need to send request body, made it POST
  post 'auth/verify_key'
  
  get 'auth/unsupported'

  # Defines the root path route ("/")
  root "domains#index"
end

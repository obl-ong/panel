# typed: true

Rails.application.routes.draw do
  use_doorkeeper_openid_connect
  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end
  use_doorkeeper_device_authorization_grant do
    controller device_authorizations: "device_authorizations"
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "/oauth/device/approve", to: "device_authorizations#approve"
  delete "/oauth/device/destroy", to: "device_authorizations#destroy"

  get "up" => "rails/health#show", :as => :rails_health_check

  resources :domains, param: :host, except: [:new] do
    collection do
      get "request", to: "domains#request_domain"
      post "provision", to: "domains#provision"
    end

    member do
      get "/", to: "records#index"
      get "email"
      get "links"
      get "settings"
      get "show", as: "show"
      patch "transfer"
      resources :records
    end
  end

  scope :admin do
    get "/", to: "admin#index"

    scope :users do
      get "/", to: "admin#users"
      get "/:id/domains", to: "admin#users_domains", as: "admin_users_domains"
    end

    scope :domains do
      get "/", to: "admin#domains"
      get "/review", to: "admin#review"
      post "/review", to: "admin#review_decision"
    end

    scope :developers do
      post "/review", to: "admin#developers_review_decision"
      get "/review", to: "admin#developers_review"
    end
  end

  get "users/register"
  post "users/create"
  get "users/email_verification"
  post "users/verify_email"
  patch "users/update"

  get "settings", to: "users#settings"

  get "auth/create_key"
  patch "auth/add_key"
  delete "auth/destroy_key"

  get "auth/login"
  get "auth/logout"
  get "auth/email", as: "auth_email"
  post "auth/verify_code", as: "verify_code"
  patch "auth/update_email_auth"
  # need to send request body, made it POST
  post "auth/verify_key"

  get "auth/unsupported"

  # Defines the root path route ("/")
  root "domains#index"

  namespace :api do
    namespace :v1 do
      resources :domains, param: :host do
        member do
          resources :records, module: "domains"
        end
      end
      get "user", to: "user#show"
      patch "user", to: "user#update"
    end
  end

  namespace :developers do
    get "/", to: redirect("developers/applications")
    resources :applications do
      member do
        post "scopes", to: "applications#add_scope"
        delete "scopes", to: "applications#destroy_scope"

        post "redirect_uris", to: "applications#add_redirect_uri"
        delete "redirect_uris", to: "applications#destroy_redirect_uri"
      end

      collection do
        get "request", to: "applications#request"
        post "provision", to: "applications#provision"
      end
    end
  end
end

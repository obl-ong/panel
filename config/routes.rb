Rails.application.routes.draw do
  get '/domains/new', to: "domains#new"
  get '/domains/:id', to: "domains#dns"
  get '/domains/', to: redirect("/")
  get '/domains/:id/dns', to: redirect("/domains/%{id}")
  get '/domains/:id/email', to: "domains#email"
  get '/domains/:id/links', to: "domains#links"
  get '/domains/:id/settings', to: "domains#settings"
  get 'users/auth'
  get 'users/login'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
   root "domains#index"
end

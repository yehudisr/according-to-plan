Rails.application.routes.draw do
  root to: 'pages#home'

  get "/login", to: "users#login", as: "login"
  post "/handle_login", to: 'users#handle_login'
  
  delete "/logout", to: "users#logout"

  resources :event_categories
  resources :categories
  resources :events
  resources :users


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
 

  get "up" => "rails/health#show", as: :rails_health_check

  resources :todos do
    resources :items
  end

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
  #this is for the logout 
  get 'auth/logout', to: "authentication#logout"

  # root "posts#index"
end

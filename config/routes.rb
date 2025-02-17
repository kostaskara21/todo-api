Rails.application.routes.draw do
 

  get "up" => "rails/health#show", as: :rails_health_check

  resources :todos do
    resources :items
  end
  # root "posts#index"
end

Rails.application.routes.draw do
  # Devise Rout 
  devise_for :users
  root to: "home#index"
end

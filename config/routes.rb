Rails.application.routes.draw do
  root 'home#index'
  # Devise Rout 
  devise_for :users
end

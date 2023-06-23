Rails.application.routes.draw do
  get 'home/index'
  # Devise Rout 
  devise_for :users
end

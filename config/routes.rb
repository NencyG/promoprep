Rails.application.routes.draw do
  resources :promos
  resources :companies
  root 'home#index'
  devise_for :users
end

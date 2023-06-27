Rails.application.routes.draw do
  resources :promos
  get 'promos/filter', to: 'promos#filter', as: 'promos_filter'
  resources :companies
  root 'home#index'
  devise_for :users
end

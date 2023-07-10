Rails.application.routes.draw do
  resources :promos
  get 'export/:company_id', to: 'promos#export', as: 'export'
  resources :companies
  root 'home#index'
  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end

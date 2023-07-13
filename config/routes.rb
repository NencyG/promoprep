Rails.application.routes.draw do
  resources :promos do
    collection do
      post :import
      get 'export/:company_id', to: 'promos#export', as: 'export'
    end
  end
  resources :companies
  root 'home#index'
  devise_for :users
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'
end

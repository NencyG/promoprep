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

  defaults format: :json do
    namespace :api  do
      namespace :v1 do
        resources :companies
      end
    end
  end
end

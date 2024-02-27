Rails.application.routes.draw do
  root 'items#index'
  devise_for :users
  resources :items
  
  resources :items do
    resources :purchases, only: [:new, :create, :index]
  end
  resources :purchases, only: [:show]
end

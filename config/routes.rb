Rails.application.routes.draw do
  resources :items
  root to: 'customers#index'
  resources :customers
  resources :orders
end

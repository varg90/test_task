Rails.application.routes.draw do
  resources :items
  root to: 'bitcoins#index'
  resources :customers
  resources :orders
  get '/bitcoins', to: 'bitcoins#index'
end

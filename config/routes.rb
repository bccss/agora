Rails.application.routes.draw do

  root 'welcome#index'

  devise_for :users
  resources :foods
  resources :transactions

  namespace :api, path: '', contraints: {subdomain: 'api'}, defaults: {format: :json} do
    resources :foods
    resources :transactions
  end

end

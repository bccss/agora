Rails.application.routes.draw do

  root 'welcome#index'
  get 'transactions/postmate', to: 'transactions#postmates_quote'

  devise_for :users
  resources :foods
  resources :transactions

end

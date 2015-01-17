Rails.application.routes.draw do

  root 'welcome#index'
  get 'transactions/postmate', to: 'transactions#postmates_quote'

  namespace :api, path: nil, constraints: { subdomain: 'api' },
            defaults: { format: :json } do
    resources :foods
    resources :transactions
  end

  devise_for :users
  resources :foods
  resources :transactions

end

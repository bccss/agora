Rails.application.routes.draw do

  root 'welcome#index'

  namespace :api, path: nil, constraints: { subdomain: 'api' },
            defaults: { format: :json } do
    resources :foods
    resources :transactions
  end

  devise_for :users, controllers: { sessions: 'sessions' }

  resources :transactions

  resources :foods do
    member do
      get 'quote'
      post 'delivery'
    end
  end

end

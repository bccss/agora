Rails.application.routes.draw do

  root 'welcome#index'
  post 'postmates/quote', to: 'postmates#quote'
  post 'postmates/delivery', to: 'postmates#delivery'

  namespace :api, path: nil, constraints: { subdomain: 'api' },
            defaults: { format: :json } do
    resources :foods
    resources :transactions
  end

  devise_for :users, controllers: { sessions: 'sessions' }
  resources :foods
  resources :transactions

end

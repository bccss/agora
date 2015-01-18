Rails.application.routes.draw do

  root 'welcome#index'

  namespace :api, path: nil, constraints: { subdomain: 'api' },
            defaults: { format: :json } do
    resources :foods do
      member do
        get 'quote'
        post 'delivery'
      end
    end
    resources :transactions, except: :index
  end

  devise_for :users, controllers: { sessions: 'sessions' }

  resources :transactions, except: :index

  resources :foods do
    member do
      get 'quote'
      post 'delivery'
    end
  end

end

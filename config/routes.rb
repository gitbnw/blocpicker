Rails.application.routes.draw do

  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :users, only: [:show]

  resources :picks, only: [:show]

  resources :portfolios do
    resources :stocks, only: [:create, :show]
  end

  root 'home#index'

  namespace :api do
    namespace :v1 do
        post '/stocks/refresh', to: 'stocks#refresh'
    end
  end

end

Rails.application.routes.draw do

  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :users, only: [:show]

  resources :picks, only: [:show]

  resources :portfolios do
    get 'intraday', to: 'portfolios#intraday'
    get 'value', to: 'portfolios#value'
    resources :stocks, only: [:create, :show]
  end
  
  resources :stocks, only: [] do
    get 'history', to: 'histories#show'
  end

  namespace :api do
     namespace :v1 do
        post '/stocks/refresh', to: 'stocks#refresh'
     end
  end
  
  post '/stocks/refresh', to: 'stocks#refresh'
  
  root 'home#index'
  
  mount Resque::Server, :at => "/resque"

end

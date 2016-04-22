Rails.application.routes.draw do

  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :users, only: [:show] do
    resources :alerts, only: [:create, :show, :destroy]
  end

  

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
        post '/stocks/get_quote', to: 'stocks#get_quote'
     end
  end
  
  post '/stocks/refresh', to: 'stocks#refresh'
  post '/alerts/initial_price', to: 'alerts#initial_price'
  
  
  root 'home#index'
  
  mount Resque::Server, :at => "/resque"

end

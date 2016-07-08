Rails.application.routes.draw do
  
  require "resque_web"

  get 'home/index'
  
  get 'users/testdrive', to: 'users#testdrive'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :users do
    resources :alerts
  end

  resources :portfolios do
    resources :stocks, only: [:create, :show]
  end
  
  resources :stocks do
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

  mount ResqueWeb::Engine => "/resque_web"

end

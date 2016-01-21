Rails.application.routes.draw do
  
  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  
  resources :users, only: [:show]
  
  resources :portfolios do
    resources :stocks, except: [:index]
  end
  
  root 'home#index'
  
end

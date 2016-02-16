Rails.application.routes.draw do

  get 'home/index'

  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }

  resources :users, only: [:show]

  resources :picks, only: [:show]

  post '/portfolios/refresh', to: 'portfolios#refresh'

  resources :portfolios do
    resources :stocks, only: [:create, :show]
  end

  namespace :api do
     namespace :v1 do
        post '/stocks/refresh', to: 'stocks#refresh'
     end
  end
  
  post '/portfolios/refresh', to: 'portfolios#refresh'

  root 'home#index'

end

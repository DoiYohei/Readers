Rails.application.routes.draw do
  
  get 'users/:id/likes', to: 'users#likes'
  get 'session/new'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
  
  root 'pages#index'
  
  resources :users do
    member do
      get :followings, :followers
    end
  end
  
  resources :relationships, only: [:create, :destroy]
  
  resources :topics
  
  resources :likes, only: [:create, :destroy]
end

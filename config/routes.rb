Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "components", to: 'pages#components'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :publications do
  	resources :comments, only: [ :create ]
  	resources :clash_requests, only: [ :create, :new, :show ]
  end

  resources :clash_requests, only: [] do
    resources :clashes, only: [ :create, :new ]
  end

  resources :clashes, only: [] do
    resources :votes, only: [ :create ]
  end

  resources :comments, only: [ :destroy ]
  resources :clash_requests, only: [ :destroy, :edit, :update ]
  resources :clashes, only: [ :destroy ]
  resources :users, only: [ :show ]
  resources :votes, only: [ :destroy ]
end

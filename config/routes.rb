Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "components", to: 'pages#components'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :publications do
  	resources :comments, only: [ :create ]
  	resources :clash_requests, only: [ :create, :new, :show ]
  end

  resources :comments, only: [ :destroy ]
  resources :users, only: [ :show ]
end

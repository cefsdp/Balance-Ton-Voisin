Rails.application.routes.draw do
  get 'publications/index'
  get 'publications/show'
  get 'publications/new'
  get 'publications/create'
  get 'publications/edit'
  get 'publications/update'
  get 'publications/destroy'
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :publications
end

Rails.application.routes.draw do
  get 'users/show'
  get 'comments/create'
  devise_for :users
  get 'prototypes/index'
  # resources :users, only: :index
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'prototypes#index'
  # post 'prototypes/index'
  resources :prototypes do
    resources :comments, only: %i[create]
  end
  resources :users, only: [:show]
end

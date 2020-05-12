Rails.application.routes.draw do
  resources :labels
  root 'sessions#new'
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :edit, :update]
  namespace :admin do
    resources :users
  end
  resources :tasks

end

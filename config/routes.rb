Rails.application.routes.draw do
  
  # devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: "about"
  devise_for :users
  resources :users, only: [:show,:index,:edit,:update]
  resources :books, only: [:show, :index, :edit, :create, :update, :destroy]
end
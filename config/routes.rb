Rails.application.routes.draw do

  # devise_for :users
  root to: 'homes#top'
  get 'home/about' => 'homes#about', as: "about"
  get '/search' => 'searches#search', as: "search"
  devise_for :users

  resources :users, only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get 'followings' => 'relationships#followings', as: 'followings'
    get 'followers' => 'relationships#followers', as: 'followers'
    get 'search' => 'users#search'
  end

  resources :books, only: [:show, :index, :edit, :create, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
  
  resources :chats, only:[:show, :create]
  
end
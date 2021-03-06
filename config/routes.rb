Rails.application.routes.draw do

  get 'groups/index'
  get 'groups/new'
  get 'groups/create'
  get 'groups/show'
  get 'groups/edit'
  get 'groups/update'
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
  
  resources :groups do
    get 'join' => 'groups#join'
    get 'new/mail' => 'groups#new_mail'
    get 'send_mail' => 'groups#send_mail'
  end
  
  
end
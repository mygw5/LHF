Rails.application.routes.draw do

  get 'groups/index'
  get 'groups/new'
  get 'groups/edit'
  get 'groups/show'
  get 'tags/show'
  get 'tags/index'
  get 'tags/edit'
  get 'searches/index'


  devise_for :users

  root to: "homes#top"
  resources :hobbies do
    resources :comments,  only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show, :edit, :update] do
    get   "confirm_withdraw"
    patch "withdraw"
  end

  resources :searches, only: [:index]

  resources :tags, only: [:index, :create, :show, :edit, :update] do
    resources :post_tags, :only: [:create, :destroy]
  end

  resources :groups, only: [:new, :create, :index, :show, :edit, :update] do
    resources :group_users, only: [:create, :destroy]
    resources :chats, only: [:create]
  end
end
Rails.application.routes.draw do

  devise_for :users

  root to: "homes#top"
  resources :post_hobbies do
    resources :comments,  only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end

  resources :users, only: [:index,:show, :edit, :update] do
    get   "confirm_withdraw"
    patch "withdraw"
  end

  resources :searches, only: [:index]

  resources :tags, only: [:index, :create, :show, :edit, :update] do
    resources :post_tags, only: [:create, :destroy]
  end

  resources :groups, only: [:new, :create, :index, :show, :edit, :update] do
    resources :group_users, only: [:create, :destroy]
    resources :chats, only: [:create]
  end
end
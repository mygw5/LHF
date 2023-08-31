Rails.application.routes.draw do

  devise_for :users

  devise_scope :user do
    post 'users/guest_sign_in', to: "users/sessions#guest_sign_in"
  end

  root to: "homes#top"
  resources :post_hobbies do
    get "drafts", on: :collection
    resources :comments,  only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
    get :favorites, on: :collection
  end

  resources :users, only: [:index,:show, :edit, :update] do
    get   "confirm_withdraw"
    patch "withdraw"
  end

  resources :searches, only: [:index]

  resources :groups, only: [:new, :create, :index, :show, :edit, :update] do
    resources :group_users, only: [:create, :destroy]
    resources :chats, only: [:create]
  end

end
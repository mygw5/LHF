Rails.application.routes.draw do
  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    resources :hobbies do
      resources :comments,  only: [:create, :destroy]
      resources :favorites, only: [:create, :destroy]
    end
    resources :users, only: [:show, :edit, :update] do
      get "confirm_withdraw"
      patch "withdraw"
    end
    resources :searches, only: [:index]
    resources :tags, only: [:show] do
      resources :post_tags, only: [:create, :destroy]
    end
    resources :groups, only: [:new, :index, :create, :edit, :update, :show] do
      resources :group_users, only: [:create, :destroy]
      resources :chats, only: [:create]
    end
  end

  namespace :admin do
   root to: "homes#top"
   resources :hobbies, only: [:index, :show, :edit, :update, :destroy] do
     resources :comments, only: [:destroy]
   end
   resources :tags,    only: [:index, :create, :edit, :update]
   resources :users,   only: [:index, :show, :edit, :update]
   resources :groups, only: [:index, :show, :edit, :update] do
     resources :chats, only: [:create]
   end
  end

end
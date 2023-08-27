Rails.application.routes.draw do
    
  get 'groups/index'
  get 'groups/new'
  get 'groups/edit'
  get 'groups/show'
  get 'tags/show'
  get 'tags/index'
  get 'tags/edit'
  get 'searches/index'
  get 'users/index'
  get 'users/show'
  get 'users/edit'
  get 'users/confirm_withdraw'
  get 'hobbies/new'
  get 'hobbies/index'
  get 'hobbies/show'
  get 'hobbies/edit'
  get 'homes/top'
  devise_for :users
  
  
end
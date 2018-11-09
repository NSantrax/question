Rails.application.routes.draw do
  devise_for :users
  
  concern :commentable do
    resources :comments
  end

  resources :quests, shallow: true, conserns: :commentable do
    resources :answers, conserns: :commentable
  end
  
  root 'quests#index'
end

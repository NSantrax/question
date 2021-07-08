Rails.application.routes.draw do
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  

  concern :commentable do

    resources :comments

  end
  
  resources :quests, concerns: :commentable, shallow: true do
      resources :answers, concerns: :commentable
  end
  
  root 'quests#index'
end

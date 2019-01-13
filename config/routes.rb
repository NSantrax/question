Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users, controllers: {omniauth_callbacks: 'omniauth_callbacks'}
  

  concern :commentable do

    resources :comments

  end
  
  resources :quests, concerns: :commentable, shallow: true do
      resources :answers, concerns: :commentable
  end

  namespace :api do
    namespace :v1 do
      resource :profiles do
        get :me, on: :collection
      end
      resources :quests
    end
  end
  
  root 'quests#index'
end

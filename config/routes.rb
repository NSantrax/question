Rails.application.routes.draw do
  devise_for :users
  resources :quests do
      resources :answers
  end
  
  root 'quests#index'
end

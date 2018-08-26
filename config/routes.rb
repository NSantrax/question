Rails.application.routes.draw do
  devise_for :users
  resources :quests do
      resources :answers, shallow: true
  end
  
  root 'quests#index'
end

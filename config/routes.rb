Rails.application.routes.draw do
  resources :quests do
      resources :answer
  end
end

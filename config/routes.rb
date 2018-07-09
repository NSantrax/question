Rails.application.routes.draw do
  resources :quests do
      resources :answers
  end
end

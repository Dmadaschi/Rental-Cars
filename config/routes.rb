Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries, only: %i[index new create show]
end

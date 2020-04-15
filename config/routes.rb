Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories, only: %i[index new create show]
  resources :customers, only: %i[index new create show]
  resources :car_models, only: %i[index]
end

Rails.application.routes.draw do
  devise_for :users
  root to: 'home#index'
  resources :manufacturers
  resources :subsidiaries
  resources :car_categories, only: %i[index new create show]
  resources :customers, only: %i[index new create show]
  resources :car_models, only: %i[index new create]
  resources :rentals, only: %i[index new create] do
    collection do
      get :search
    end
  end
end

Rails.application.routes.draw do
  devise_for :users

  root to: 'home#index'

  resources :manufacturers

  resources :subsidiaries

  resources :car_categories, only: %i[index new create show]

  resources :customers, only: %i[index new create show] do
    collection do
      get :search
    end
  end

  resources :car_models, only: %i[index new create]

  resources :rentals, only: %i[index new create show] do
    resources :car_rentals, only: [:create]
    collection do
      get :search
    end
    member do
      get :start
    end
  end

  resources :cars, only: %i[index new create show]

  namespace :api do
    namespace :v1 do
      resources :cars, only: %i[index show create] do
        member do
          patch :status
        end
      end
    end
  end
end

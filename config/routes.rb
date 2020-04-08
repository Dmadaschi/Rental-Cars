Rails.application.routes.draw do
  root to: 'home#index'
  resources :manufacturers, only: [
    :index, :show, :new, :create, :destroy, :edit, :update
  ]
  resources :subsidiaries, only: [:index, :new, :create, :show]
end
